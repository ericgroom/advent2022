defmodule Advent2022.Days.Day5Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day5

  @example_input """
                     [D]\s\s\s
                 [N] [C]\s\s\s
                 [Z] [M] [P]
                  1   2   3

                 move 1 from 2 to 1
                 move 3 from 1 to 3
                 move 2 from 2 to 1
                 move 1 from 1 to 2
                 """
                 |> Day5.parse()

  describe "part_one" do
    test "example input" do
      assert Day5.part_one(@example_input) == "CMZ"
    end

    test "real input" do
      assert Day5.part_one() == "TDCHVHJTG"
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day5.part_two(@example_input) == "MCD"
    end

    test "real input" do
      assert Day5.part_two() == "NGCMPJLHV"
    end
  end
end
