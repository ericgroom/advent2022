defmodule Advent2022.Days.Day7Test do
  use ExUnit.Case, async: true
  alias Advent2022.Days.Day7

  @example_input """
                 $ cd /
                 $ ls
                 dir a
                 14848514 b.txt
                 8504156 c.dat
                 dir d
                 $ cd a
                 $ ls
                 dir e
                 29116 f
                 2557 g
                 62596 h.lst
                 $ cd e
                 $ ls
                 584 i
                 $ cd ..
                 $ cd ..
                 $ cd d
                 $ ls
                 4060174 j
                 8033020 d.log
                 5626152 d.ext
                 7214296 k
                 """
                 |> Day7.parse()

  describe "part_one" do
    test "example input" do
      assert Day7.part_one(@example_input) == 95437
    end

    test "real input" do
      assert Day7.part_one() == 1_325_919
    end
  end

  describe "part_two" do
    test "example input" do
      assert Day7.part_two(@example_input) == 24_933_642
    end

    test "real input" do
      assert Day7.part_two() == 2_050_735
    end
  end
end
