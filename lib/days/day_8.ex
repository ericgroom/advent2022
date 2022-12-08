defmodule Advent2022.Days.Day8 do
  use Advent2022.Day
  alias Advent2022.{Vec2D, Grid}

  def part_one(input) do
    Grid.coords(input)
    |> Enum.map(fn coord ->
      tree_at_coord = Grid.at(input, coord)

      Vec2D.nondiagonal_unit_vectors()
      |> Enum.map(fn direction ->
        neighbors = neighbors_in_direction(input, coord, direction)
        obscured = Enum.any?(neighbors, &(&1 >= tree_at_coord))
        Enum.empty?(neighbors) or !obscured
      end)
      |> Enum.any?()
    end)
    |> Enum.filter(& &1)
    |> Enum.count()
  end

  def part_two(input) do
    Grid.coords(input)
    |> Enum.map(fn coord ->
      tree_at_coord = Grid.at(input, coord)

      Vec2D.nondiagonal_unit_vectors()
      |> Enum.map(fn direction ->
        neighbors_in_direction(input, coord, direction)
        |> take_while_inclusive(&(&1 < tree_at_coord))
        |> Enum.count()
      end)
    end)
    |> Enum.map(&Enum.product/1)
    |> Enum.max()
  end

  defp neighbors_in_direction(grid, from, direction) do
    Stream.unfold(from, fn coord ->
      next = Vec2D.add(coord, direction)
      {next, next}
    end)
    |> Enum.reduce_while([], fn coord, acc ->
      case Grid.at(grid, coord) do
        :invalid_coord -> {:halt, acc}
        value -> {:cont, [value | acc]}
      end
    end)
    |> Enum.reverse()
  end

  defp take_while_inclusive(enumerable, f) do
    enumerable
    |> Enum.reduce_while([], fn el, acc ->
      if f.(el) do
        {:cont, [el | acc]}
      else
        {:halt, [el | acc]}
      end
    end)
    |> Enum.reverse()
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(fn line ->
      String.graphemes(line)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Grid.new()
  end
end
