defmodule Mix.Tasks.NewDay do
  use Mix.Task

  def run([day_no | rest]) do
    day_no = String.to_integer(day_no)

    root = File.cwd!()
    day_source_path = Path.join([root, "lib", "days", "day_#{day_no}.ex"])
    day_input_path = Advent2022.Inputs.input_path(day_no)
    day_test_path = Path.join([root, "test", "days", "day_#{day_no}_test.exs"])

    if File.exists?(day_source_path) or File.exists?(day_input_path) or
         File.exists?(day_test_path) do
      raise "One more more files already exist for this day, exiting"
    end

    case rest do
      ["n" | _] ->
        File.touch!(day_input_path)

      _ ->
        Advent2022.Inputs.download_input(day_no)
    end

    File.write!(day_source_path, """
    defmodule Advent2022.Days.Day#{day_no} do
      use Advent2022.Day

      def part_one(input) do
        input
      end

      def parse(raw) do
        raw
        |> Parser.parse_list(&String.to_integer/1)
      end
    end
    """)

    File.write!(day_test_path, """
    defmodule Advent2022.Days.Day#{day_no}Test do
      use ExUnit.Case, async: true
      alias Advent2022.Days.Day#{day_no}

      @example_input \"""
      42
      \"""
      |> Day#{day_no}.parse()

      describe "part_one" do
        test "example input" do
          assert Day#{day_no}.part_one(@example_input) == [42]
        end
      end

      describe "part_two" do
        test "example input" do
          # assert Day#{day_no}.part_two(@example_input) == [42]
        end
      end
    end
    """)
  end
end
