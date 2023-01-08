# Set language-specific versioning
ARG ELIXIR_VSN=1.14.2

# Set args for image overrides
ARG BUILDER_REGISTRY=docker.io
ARG BUILDER_REGISTRY_PATH=library
ARG BUILDER_BASE_IMAGE=elixir
ARG BUILDER_BASE_IMAGE_TAG=${ELIXIR_VSN}-alpine
ARG RUNNER_REGISTRY=$BUILDER_REGISTRY
ARG RUNNER_REGISTRY_PATH=$BUILDER_REGISTRY_PATH
ARG RUNNER_BASE_IMAGE=$BUILDER_BASE_IMAGE
ARG RUNNER_BASE_IMAGE_TAG=$BUILDER_BASE_IMAGE_TAG

# Set a base directory ARG for running the build of your app
ARG APP_DIR=/opt/app

# Set an ARG for switching app build envs
ARG MIX_ENV=prod

# Dependency acquisition configuration
ARG UPDATE_ELIXIR_DEPS=false
ARG GET_ALL_ELIXIR_DEPS=false

# Generate PLTs for caching
ARG GEN_PLTS=false

# Set any other args shared between build stages
ARG OTP_APP=elixir_dev

# Build stage
FROM ${BUILDER_REGISTRY}/${BUILDER_REGISTRY_PATH}/${BUILDER_BASE_IMAGE}:${BUILDER_BASE_IMAGE_TAG} AS builder-base

# Import necessary ARGs defined at top level
ARG APP_DIR
ARG MIX_ENV
ARG ELIXIR_VSN

# Persist necessary ARGs as ENVs for use in CI
ENV MIX_ENV $MIX_ENV
ENV MIX_HOME $APP_DIR/.mix
ENV HEX_HOME $APP_DIR/.hex
ENV REBAR_CACHE_DIR $APP_DIR/.rebar_cache
ENV ELIXIR_VSN $ELIXIR_VSN

WORKDIR $APP_DIR

# Copy all src. Leverage .dockerignore to exclude unnecessary files.
# This will copy any host directories used for local dependency
# caching if they exist in the root of the repository.
COPY . .

FROM builder-base AS os-deps
ARG MIX_ENV

# Install build deps
# RUN apk add --no-cache ...

# Install test deps if not cutting a prod release
RUN if [ "${MIX_ENV}" != 'prod' ]; then \
      apk add --no-cache yamllint git ; \
    fi

FROM os-deps AS hex
# Install local package manager caches if missing (see above note re: COPY . $APP_DIR)
# Build, overwriting any extant build artifacts copied in from the host filesystem
RUN mix do local.hex --force --if-missing, \
    local.rebar --force --if-missing

FROM hex AS mix-deps
ARG GET_ALL_ELIXIR_DEPS
# Get dependencies for the currently configured environment
RUN if [ "${GET_ALL_ELIXIR_DEPS}" = 'true' ]; then \
      mix deps.get ; \
    else \
      mix deps.get --only ${MIX_ENV} ; \
    fi

FROM mix-deps AS updated
ARG UPDATE_ELIXIR_DEPS
# Update deps if desired
RUN if [ "${UPDATE_ELIXIR_DEPS}" = 'true' ]; then \
      mix deps.update --all ; \
    fi

FROM updated AS compiled-deps
# Compile dependencies
RUN mix deps.compile

FROM compiled-deps AS compiled
ARG MIX_ENV
# Compile
RUN if [ "${MIX_ENV}" = 'test' ]; then \
      mix compile --warnings-as-errors ; \
    else \
      mix compile ; \
    fi

FROM compiled AS plts
ARG MIX_ENV
ARG GEN_PLTS
RUN if [ "${MIX_ENV}" = 'test' ] && [ "${GEN_PLTS}" = 'true' ]; then \
      mix dialyzer --plt ; \
    fi

FROM plts AS deployed
# Deploy
RUN mix release --overwrite --no-compile

# GitHub Actions will break if any cached directories don't exist in the
# generated container. Ensure they exist
# RUN mkdir -p deps .rebar_eache .hex

# Runner stage
# Using the same image as the builder assures compatibility between [build|run]time
FROM ${RUNNER_REGISTRY}/${RUNNER_REGISTRY_PATH}/${RUNNER_BASE_IMAGE}:${RUNNER_BASE_IMAGE_TAG}

# Import necessary ARGs defined at top level
ARG APP_DIR
ARG OTP_APP
ARG MIX_ENV

# Copy from the built directory into the runner stage at the same directory
ARG BUILD_DIR=$APP_DIR/_build
WORKDIR $BUILD_DIR
COPY --from=deployed $BUILD_DIR/$MIX_ENV/rel/$OTP_APP .
COPY --from=deployed /opt/app/priv/repo/seeds ./seeds

# Preserve the deploy environment in an ENV if necessary
# ENV MIX_ENV $MIX_ENV

# Use CMD to allow overrides when invoked via `docker container run`
CMD [ "./bin/server" ]
