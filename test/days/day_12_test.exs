defmodule Advent2022.Days.Day12Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day12

  @example_input """
                 Sabqponm
                 abcryxxl
                 accszExk
                 acctuvwj
                 abdefghi
                 """
                 |> Day12.parse()

  describe "part_one" do
    test "example input" do
      assert Day12.part_one(@example_input) == 31
    end

    @tag :slow
    test "real input" do
      assert Day12.part_one() == 462
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day12.part_two(@example_input) == 29
    end

    @tag :slow
    test "real input" do
      assert Day12.part_two() == 451
    end
  end
end
