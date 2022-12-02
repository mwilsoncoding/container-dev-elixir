import Config

# # Ecto for Postgres
# config :elixir_dev, ElixirDev.Repo,
#   username: "elixir_dev",
#   password: "pg",
#   database: "elixir_dev",
#   hostname: "pg",
#   # Comment out the pool if you want to rid yourself of ignorable postgrex connection issues in iex when MIX_ENV=dev
#   pool: Ecto.Adapters.SQL.Sandbox

# # Broadway for RabbitMQ
# config :elixir_dev, :rabbitmq,
#   username: "rmq",
#   password: "rmq",
#   host: "rabbitmq",
#   producer: BroadwayRabbitMQ.Producer
#
# config :elixir_dev, ElixirDev.Application, enable_broadway: true
#
# config :elixir_dev, ElixirDev.Broadway.Action1, queue: "args_queue_1"
# config :elixir_dev, ElixirDev.Broadway.Action2, queue: "args_queue_2"
# config :elixir_dev, ElixirDev.Broadway.Action3, queue: "args_queue_3"

# Logging
config :logger,
  backends: [:console],
  level: :info
