defmodule Advent2022.Parser do
  def parse_list(raw, f \\ & &1) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.map(f)
  end

  def parse_nested_list(raw, f \\ & &1) do
    raw
    |> String.split("\n\n", trim: true)
    |> Enum.map(&parse_list(&1, f))
  end
end
