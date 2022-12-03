defmodule Advent2022.Days.Day3 do
  use Advent2022.Day

  def part_one(input) do
    input
    |> Enum.map(fn items ->
      count = Enum.count(items)
      if rem(count, 2) != 0, do: raise("invalid input")
      {first_half, second_half} = Enum.split(items, div(count, 2))

      MapSet.intersection(MapSet.new(first_half), MapSet.new(second_half))
      |> Enum.into([])
      |> List.first()
    end)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end

  def part_two(input) do
    input
    |> Enum.chunk_every(3)
    |> Enum.map(fn group ->
      group
      |> Enum.map(&MapSet.new/1)
      |> Enum.reduce(&MapSet.intersection/2)
      |> Enum.into([])
      |> List.first()
    end)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end

  defp priority(char) do
    ascii = String.to_charlist(char) |> List.first()

    if String.upcase(char) == char do
      ascii - ?A + 27
    else
      ascii - ?a + 1
    end
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(&String.graphemes/1)
  end
end
