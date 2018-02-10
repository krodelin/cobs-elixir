defmodule CobsTest do
  use ExUnit.Case
  doctest Cobs

  test "greets the world" do
    assert Cobs.hello() == :world
  end
end
