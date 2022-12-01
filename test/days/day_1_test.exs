defmodule Advent2022.Days.Day1Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day1

  @example_input """
                 1000
                 2000
                 3000

                 4000

                 5000
                 6000

                 7000
                 8000
                 9000

                 10000
                 """
                 |> Day1.parse()

  describe "part_one" do
    test "example input" do
      assert Day1.part_one(@example_input) == 24000
    end

    test "real input" do
      assert Day1.part_one() == 68802
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day1.part_two(@example_input) == 45000
    end

    test "real input" do
      assert Day1.part_two() == 205_370
    end
  end
end
