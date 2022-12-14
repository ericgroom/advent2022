defmodule Advent2022.Days.Day11Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day11

  @example_input """
                 Monkey 0:
                 Starting items: 79, 98
                 Operation: new = old * 19
                 Test: divisible by 23
                 If true: throw to monkey 2
                 If false: throw to monkey 3

                 Monkey 1:
                 Starting items: 54, 65, 75, 74
                 Operation: new = old + 6
                 Test: divisible by 19
                 If true: throw to monkey 2
                 If false: throw to monkey 0

                 Monkey 2:
                 Starting items: 79, 60, 97
                 Operation: new = old * old
                 Test: divisible by 13
                 If true: throw to monkey 1
                 If false: throw to monkey 3

                 Monkey 3:
                 Starting items: 74
                 Operation: new = old + 3
                 Test: divisible by 17
                 If true: throw to monkey 0
                 If false: throw to monkey 1
                 """
                 |> Day11.parse()

  describe "part_one" do
    test "example input" do
      assert Day11.part_one(@example_input) == 10605
    end

    test "real input" do
      assert Day11.part_one() == 98280
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day11.part_two(@example_input) == 2_713_310_158
    end

    test "real input" do
      assert Day11.part_two() == 17_673_687_232
    end
  end
end
