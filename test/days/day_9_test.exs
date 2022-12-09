defmodule Advent2022.Days.Day9Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day9

  @example_input """
                 R 4
                 U 4
                 L 3
                 D 1
                 R 4
                 D 1
                 L 5
                 R 2
                 """
                 |> Day9.parse()

  describe "part_one" do
    test "example input" do
      assert Day9.part_one(@example_input) == 13
    end

    test "real input" do
      assert Day9.part_one() == 6023
    end
  end

  describe "part_two" do
    test "example input" do
      # assert Day9.part_two(@example_input) == [42]
    end
  end
end
