import Config

config :elixir_dev, ElixirDev.MixProject, elixir_vsn: System.get_env("ELIXIR_VSN", "1.14.2")

config :elixir_dev, ElixirDev.Application, k8s_probe_port: 9090

# config :elixir_dev,
#   ecto_repos: [ElixirDev.Repo]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
