defmodule Advent2022.Days.Day6Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day6

  @example_input """
                 mjqjpqmgbljsphdztnvjfqwrcgsmlb
                 """
                 |> Day6.parse()

  describe "part_one" do
    test "example input" do
      assert Day6.part_one(@example_input) == 7
    end

    test "real input" do
      assert Day6.part_one() == 1100
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day6.part_two(@example_input) == 19
    end

    test "real input" do
      assert Day6.part_two() == 2421
    end
  end
end
