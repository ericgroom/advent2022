defmodule Advent2022.Days.Day5 do
  use Advent2022.Day

  def part_one({columns, instructions}) do
    follow_instructions(columns, instructions, &move/4)
  end

  def part_two({columns, instructions}) do
    follow_instructions(columns, instructions, &move_multiple/4)
  end

  defp move(columns, from, to, quantity) do
    from_column = Map.fetch!(columns, from)
    to_column = Map.fetch!(columns, to)

    {to_move, new_from} = Enum.split(from_column, quantity)
    new_to = Enum.reverse(to_move) ++ to_column

    %{columns | from => new_from, to => new_to}
  end

  defp move_multiple(columns, from, to, quantity) do
    from_column = Map.fetch!(columns, from)
    to_column = Map.fetch!(columns, to)

    {to_move, new_from} = Enum.split(from_column, quantity)
    new_to = to_move ++ to_column

    %{columns | from => new_from, to => new_to}
  end

  defp follow_instructions(columns, instructions, mover) do
    Enum.reduce(instructions, columns, fn instruction, columns ->
      %{quantity: quantity, source: source, destination: destination} = instruction

      mover.(columns, source, destination, quantity)
    end)
    |> Enum.to_list()
    |> Enum.sort_by(fn {index, _} -> index end)
    |> Enum.map(fn {_, [top | _]} -> top end)
    |> Enum.join()
  end

  def parse(raw) do
    [stacks_raw, instructions_raw] = String.split(raw, "\n\n", trim: true)

    instruction_pattern = ~r/move (?<quantity>\d+) from (?<source>\d+) to (?<destination>\d+)/

    instructions =
      Parser.parse_list(instructions_raw, &Regex.named_captures(instruction_pattern, &1))
      |> Enum.map(fn %{"destination" => destination, "quantity" => quantity, "source" => source} ->
        %{
          destination: String.to_integer(destination),
          quantity: String.to_integer(quantity),
          source: String.to_integer(source)
        }
      end)

    stack_columns =
      stacks_raw
      |> String.split("\n", trim: true)
      |> Enum.map(&String.slice(&1, 1..-1//4))
      |> Enum.map(&String.graphemes/1)
      |> Enum.zip_with(& &1)

    columns =
      stack_columns
      |> Enum.map(fn column ->
        Enum.reject(column, &(&1 == " "))
      end)
      |> Enum.with_index()
      |> Enum.map(fn {col, index} -> {index + 1, col} end)
      |> Map.new()

    {columns, instructions}
  end
end
