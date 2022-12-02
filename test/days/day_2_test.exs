defmodule Advent2022.Days.Day2Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day2

  @example_input """
                 A Y
                 B X
                 C Z
                 """
                 |> Day2.parse()

  describe "part_one" do
    test "example input" do
      assert Day2.part_one(@example_input) == 15
    end

    test "real input" do
      assert Day2.part_one() == 9651
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day2.part_two(@example_input) == 12
    end

    test "real input" do
      assert Day2.part_two() == 10560
    end
  end
end
