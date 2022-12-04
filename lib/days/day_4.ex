defmodule Advent2022.Days.Day4 do
  use Advent2022.Day

  def part_one(input) do
    input
    |> Enum.count(fn {first, second} ->
      range_fully_contains?(first, second) || range_fully_contains?(second, first)
    end)
  end

  def part_two(input) do
    input
    |> Enum.count(fn {first, second} ->
      !Range.disjoint?(first, second)
    end)
  end

  defp range_fully_contains?(parent, child) do
    parent_set = MapSet.new(parent)
    child_set = MapSet.new(child)
    MapSet.equal?(MapSet.intersection(parent_set, child_set), child_set)
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(fn pair ->
      [first, second] = String.split(pair, ",") |> Enum.map(&parse_range/1)
      {first, second}
    end)
  end

  defp parse_range(range) do
    [start, finish] = String.split(range, "-")
    String.to_integer(start)..String.to_integer(finish)
  end
end
