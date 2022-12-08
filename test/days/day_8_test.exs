defmodule Advent2022.Days.Day8Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day8

  @example_input """
                 30373
                 25512
                 65332
                 33549
                 35390
                 """
                 |> Day8.parse()

  describe "part_one" do
    test "example input" do
      assert Day8.part_one(@example_input) == 21
    end

    test "real input" do
      assert Day8.part_one() == 1713
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day8.part_two(@example_input) == 8
    end

    test "real input" do
      assert Day8.part_two() == 268_464
    end
  end
end
