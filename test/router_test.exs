defmodule RouterTest do
  use ExUnit.Case
  doctest Router

  test "user post" do
    assert Gaibu.hello() == :world
  end
end
