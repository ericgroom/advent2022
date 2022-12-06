defmodule Advent2022.Days.Day6 do
  use Advent2022.Day

  def part_one(input) do
    index_of_first_marker(input, 4)
  end

  def part_two(input) do
    index_of_first_marker(input, 14)
  end

  defp index_of_first_marker(input, unique_count) do
    index =
      input
      |> Stream.chunk_every(unique_count, 1)
      |> Stream.map(&MapSet.new/1)
      |> Enum.find_index(fn el -> Enum.count(el) == unique_count end)

    index + unique_count
  end

  def parse(raw) do
    raw
    |> String.graphemes()
  end
end
