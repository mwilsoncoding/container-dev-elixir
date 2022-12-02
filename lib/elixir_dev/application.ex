defmodule ElixirDev.Application do
  @moduledoc false

  use Application

  require Logger

  @impl true
  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    children = [
      # ElixirDev.Repo,
      {K8sProbe,
       port: Application.fetch_env!(:elixir_dev, __MODULE__) |> Keyword.fetch!(:k8s_probe_port)}
    ]

    # |> (fn c ->
    #       if Application.fetch_env!(:elixir_dev, __MODULE__)
    #          |> Keyword.fetch!(:enable_broadway) == true do
    #         c ++
    #           [
    #             ElixirDev.Broadway.Action1,
    #             ElixirDev.Broadway.Action2,
    #             ElixirDev.Broadway.Action3
    #           ]
    #       else
    #         c
    #       end
    #     end).()

    opts = [strategy: :one_for_one, name: ElixirDev.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
