defmodule ElixirDev.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_dev,
      version: "0.1.0",
      elixir: Application.get_env(__MODULE__, :elixir_vsn),
      start_permanent: Mix.env() == :prod,
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      aliases: aliases(),
      dialyzer: [
        plt_add_apps: [:ex_unit]
      ]
    ]
  end

  defp aliases do
    [
      # test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],
      # "ecto.reset": ["ecto.drop --quiet", "ecto.create --quiet", "ecto.migrate --quiet"]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(env) when env == :test or env == :dev, do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ElixirDev.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_audit, "~> 2.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      # {:ecto_sql, "~> 3.9"},
      # {:postgrex, "~> 0.16.5"},
      # {:broadway_rabbitmq, "~> 0.7"},
      # {:json, "~> 1.4"},
      {:k8s_probe, "~> 0.4.1"}
    ]
  end
end
