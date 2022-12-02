defmodule ElixirDevTest do
  use ExUnit.Case
  doctest ElixirDev

  test "greets the world" do
    assert ElixirDev.hello() == "hello"
  end
end
