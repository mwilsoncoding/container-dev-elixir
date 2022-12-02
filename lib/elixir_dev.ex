defmodule ElixirDev do
  @moduledoc """
  Development environment for Elixir.

  This module represents the external API of the application.
  """
  require Logger

  @hi "hello"

  @doc """
  Says, logs, and returns "hello"
  """
  @spec hello() :: String.t()
  def hello() do
    IO.puts(@hi)
    Logger.info("Said #{@hi} at: #{Time.utc_now()}")
    @hi
  end
end
