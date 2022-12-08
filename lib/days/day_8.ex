defmodule Advent2022.Days.Day8 do
  use Advent2022.Day
  alias Advent2022.{Vec2D, Grid}

  def part_one(input) do
    Grid.coords(input)
    |> Enum.map(fn coord ->
      value_at_coord = Grid.at(input, coord)

      Vec2D.nondiagonal_unit_vectors()
      |> Enum.map(fn direction ->
        Stream.unfold(coord, fn coord ->
          next = Vec2D.add(direction, coord)
          {next, next}
        end)
        |> Enum.reduce_while(true, fn test_coord, _acc ->
          case Grid.at(input, test_coord) do
            :invalid_coord ->
              {:halt, true}

            test_value ->
              if test_value < value_at_coord do
                {:cont, true}
              else
                {:halt, false}
              end
          end
        end)
      end)
      |> Enum.any?()
    end)
    |> Enum.filter(& &1)
    |> Enum.count()
  end

  def part_two(input) do
    Grid.coords(input)
    |> Enum.map(fn coord ->
      value_at_coord = Grid.at(input, coord)

      Vec2D.nondiagonal_unit_vectors()
      |> Enum.map(fn direction ->
        Stream.unfold(coord, fn coord ->
          next = Vec2D.add(direction, coord)
          {next, next}
        end)
        |> Enum.reduce_while(0, fn test_coord, acc ->
          case Grid.at(input, test_coord) do
            :invalid_coord ->
              {:halt, acc}

            test_value ->
              if test_value < value_at_coord do
                {:cont, acc + 1}
              else
                {:halt, acc + 1}
              end
          end
        end)
      end)
    end)
    |> Enum.map(&Enum.product/1)
    |> Enum.max()
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
