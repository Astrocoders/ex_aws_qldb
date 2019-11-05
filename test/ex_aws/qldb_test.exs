defmodule ExAws.QLDBTest do
  use ExUnit.Case
  doctest ExAws.QLDB

  test "greets the world" do
    assert ExAws.QLDB.hello() == :world
  end
end
