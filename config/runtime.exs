import Config

if config_env() == :prod do
  # # Ecto for Postgres
  #   config :elixir_dev, ElixirDev.Repo,
  #     username: System.get_env("DB_USERNAME", "elixir_dev"),
  #     password: System.fetch_env!("DB_PASSWORD"),
  #     database: System.get_env("DB_NAME", "elixir_dev"),
  #     hostname: System.get_env("DB_HOST", "pg")

  # Seeds for various environments
  #   default_seeds_file = "/opt/app/_build/seeds/seeds.exs"
  #   config :elixir_dev, seeds_file: System.get_env("SEEDS_FILE", default_seeds_file)

  # # Broadway for RabbitMQ
  #   config :elixir_dev, ElixirDev.Broadway.Action1,
  #     queue: System.get_env("QUEUE_ACTION_1", "args_queue_1")
  #
  #   config :elixir_dev, ElixirDev.Broadway.Action2,
  #     queue: System.get_env("QUEUE_ACTION_2", "args_queue_2")
  #
  #   config :elixir_dev, ElixirDev.Broadway.Action3,
  #     queue: System.get_env("QUEUE_ACTION_3", "args_queue_3")
  #
  #   config :elixir_dev, ElixirDev.Application,
  #     enable_broadway:
  #       System.get_env("ENABLE_BROADWAY", "true") |> String.downcase() |> String.to_existing_atom()
  #
  #   rabbitmq_pass =
  #     if System.get_env("ENABLE_BROADWAY", "true")
  #        |> String.downcase()
  #        |> String.to_existing_atom() == true do
  #       System.fetch_env!("RABBITMQ_PASSWORD")
  #     else
  #       System.get_env("RABBITMQ_PASSWORD", "")
  #     end
  #
  #   config :elixir_dev, :rabbitmq,
  #     host: System.get_env("RABBITMQ_HOST", "rabbitmq"),
  #     username: System.get_env("RABBITMQ_USERNAME", "rmq"),
  #     password: rabbitmq_pass,
  #     producer: BroadwayRabbitMQ.Producer

  # Something for kubernetes to probe to see if the BEAM is up
  default_k8s_probe_port = "9090"

  config :elixir_dev, ElixirDev.Application,
    k8s_probe_port: String.to_integer(System.get_env("PROBE_PORT", default_k8s_probe_port))

  # Logging
  config :logger,
    backends: [:console],
    level: System.get_env("LOG_LEVEL", "info") |> String.downcase() |> String.to_existing_atom()
end

if config_env() == :test do
  # # Ecto for Postgres
  #   config :elixir_dev, ElixirDev.Repo,
  #     username: System.get_env("DB_USERNAME", "elixir_dev"),
  #     password: System.get_env("DB_PASSWORD", "pg"),
  #     database: System.get_env("DB_NAME", "elixir_dev"),
  #     hostname: System.get_env("DB_HOST", "localhost"),
  #     pool: Ecto.Adapters.SQL.Sandbox

  # # Broadway for RabbitMQ
  #   config :elixir_dev, ElixirDev.Broadway.Action1,
  #     queue: System.get_env("QUEUE_ACTION_1", "args_queue_1")
  #
  #   config :elixir_dev, ElixirDev.Broadway.Action2,
  #     queue: System.get_env("QUEUE_ACTION_2", "args_queue_2")
  #
  #   config :elixir_dev, ElixirDev.Broadway.Action3,
  #     queue: System.get_env("QUEUE_ACTION_3", "args_queue_3")
  #
  #   config :elixir_dev, :rabbitmq,
  #     host: System.get_env("RABBITMQ_HOST", "rabbitmq"),
  #     username: System.get_env("RABBITMQ_USERNAME", "rmq"),
  #     password: System.get_env("RABBITMQ_PASSWORD", "rmq"),
  #     producer: Broadway.DummyProducer
  #
  #   config :elixir_dev, ElixirDev.Application,
  #     enable_broadway:
  #       System.get_env("ENABLE_BROADWAY", "false") |> String.downcase() |> String.to_existing_atom()

  config :logger,
    backends: [:console],
    level: System.get_env("LOG_LEVEL", "notice") |> String.downcase() |> String.to_existing_atom()
end
