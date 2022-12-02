# defmodule ElixirDev.Broadway.Action3 do
#   @moduledoc false
#   use Broadway
#
#   @spec start_link(any) :: :ignore | {:error, any} | {:ok, pid}
#   def start_link(_opts) do
#     Broadway.start_link(__MODULE__,
#       name: Action3,
#       producer: [
#         module:
#           {Application.fetch_env!(:elixir_dev, :rabbitmq) |> Keyword.fetch!(:producer),
#            on_failure: :reject,
#            queue: Application.fetch_env!(:elixir_dev, __MODULE__) |> Keyword.fetch!(:queue),
#            declare: [durable: true],
#            connection: [
#              host: Application.fetch_env!(:elixir_dev, :rabbitmq) |> Keyword.fetch!(:host),
#              username:
#                Application.fetch_env!(:elixir_dev, :rabbitmq) |> Keyword.fetch!(:username),
#              password:
#                Application.fetch_env!(:elixir_dev, :rabbitmq) |> Keyword.fetch!(:password)
#            ],
#            qos: [
#              prefetch_count: 50
#            ]},
#         concurrency: 1
#       ],
#       processors: [
#         default: [
#           concurrency: 50
#         ]
#       ]
#     )
#   end
#
#   @doc """
#   Async message ingestion for hello.
#   Example JSON message:
#     {}
#   """
#   @impl true
#   def handle_message(_, message, _) do
#     %{} =
#       message.data |> JSON.decode!()
#
#     ElixirDev.hello()
#     message
#   end
# end
