# defmodule ElixirDev.RepoCase do
#   @moduledoc false
#   use ExUnit.CaseTemplate
#
#   using do
#     quote do
#       alias ElixirDev.Repo
#
#       import Ecto
#       import Ecto.Query
#       import ElixirDev.RepoCase
#     end
#   end
#
#   setup tags do
#     :ok = Ecto.Adapters.SQL.Sandbox.checkout(ElixirDev.Repo)
#
#     unless tags[:async] do
#       Ecto.Adapters.SQL.Sandbox.mode(ElixirDev.Repo, {:shared, self()})
#     end
#
#     :ok
#   end
# end
