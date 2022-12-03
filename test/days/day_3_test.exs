defmodule Advent2022.Days.Day3Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day3

  @example_input """
                 vJrwpWtwJgWrhcsFMMfFFhFp
                 jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
                 PmmdzqPrVvPwwTWBwg
                 wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
                 ttgJtRGJQctTZtZT
                 CrZsJsPPZsGzwwsLwLmpwMDw
                 """
                 |> Day3.parse()

  describe "part_one" do
    test "example input" do
      assert Day3.part_one(@example_input) == 157
    end

    test "real input" do
      assert Day3.part_one() == 8123
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day3.part_two(@example_input) == 70
    end

    test "real input" do
      assert Day3.part_two() == 2620
    end
  end
end
