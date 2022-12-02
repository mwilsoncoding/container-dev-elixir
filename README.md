# container-dev-elixir

An opinionated starting point for containerized development in Elixir.

## How to Use

- Follow [the official instructions](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template) on creating a new repo from a template.
- Modify new repository settings per your requirements.
- Replace the OTP app name/Module from `elixir_dev`/`ElixirDev` to your application of choice. This is mentioned in many files, so a find/replace all would be useful here.
- Customize the resultant application per your requirements.

## Built ins

- Codespaces support
- [CI](.github/workflows/ci.yml)/[CD](.github/workflows/publish.yml) using GitHub for Actions and Container Registry
- Unit, Credo, and Dialyzer tests
- Containerization out of the gate with kubernetes considerations
- Cached build support
- Support for data directory caches for service dependencies
- `dev`, `test`, and `prod` environment consideration for development, CI, and deployment, respectively
- Security scanning via [MixAudit](.github/workflows/ci.yml)
- Dependency scanning via [dependabot](.github/dependabot.yaml)
- Container scanning via [Trivy](.github/workflows/trivy.yml)
- Vulnerability reporting via GitHub Security reporting