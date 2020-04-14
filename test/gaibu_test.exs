defmodule GaibuTest do
  use ExUnit.Case
  doctest Gaibu

  test "greets the world" do
    assert Gaibu.hello() == :world
  end
end
