defmodule Advent2022.Days.Day1 do
  use Advent2022.Day

  def part_one(input) do
    input
    |> Enum.map(&Enum.sum/1)
    |> Enum.max()
  end

  def part_two(input) do
    input
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end

  def parse(raw) do
    raw
    |> Parser.parse_nested_list(&String.to_integer/1)
  end
end
