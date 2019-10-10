defmodule NetworkedLedsTest do
  use ExUnit.Case
  doctest NetworkedLeds

  test "greets the world" do
    assert NetworkedLeds.hello() == :world
  end
end
