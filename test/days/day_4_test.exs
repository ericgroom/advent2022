defmodule Advent2022.Days.Day4Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day4

  @example_input """
                 2-4,6-8
                 2-3,4-5
                 5-7,7-9
                 2-8,3-7
                 6-6,4-6
                 2-6,4-8
                 """
                 |> Day4.parse()

  describe "part_one" do
    test "example input" do
      assert Day4.part_one(@example_input) == 2
    end

    test "real input" do
      assert Day4.part_one() == 441
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day4.part_two(@example_input) == 4
    end

    test "real input" do
      assert Day4.part_two() == 861
    end
  end
end
