defmodule Advent2022.Days.Day2Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day2

  @example_input """
  42
  """
  |> Day2.parse()

  describe "part_one" do
    test "example input" do
      assert Day2.part_one(@example_input) == [42]
    end
  end

  describe "part_two" do
    test "example input" do
      # assert Day2.part_two(@example_input) == [42]
    end
  end
end
