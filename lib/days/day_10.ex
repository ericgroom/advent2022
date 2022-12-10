defmodule Advent2022.Days.Day10 do
  use Advent2022.Day

  def part_one(input) do
    x_values(input)
    |> then(&[1 | &1])
    |> Enum.with_index(1)
    |> Enum.drop(19)
    |> Enum.take_every(40)
    |> Enum.map(fn {x, y} -> x * y end)
    |> Enum.sum()
  end

  def part_two(input) do
    x_values(input)
    |> then(&[1 | &1])
    |> Enum.with_index(1)
    |> Enum.drop(-1)
    |> Enum.reduce("", fn {x, cycle}, crt ->
      crt_pos = rem(cycle - 1, 40)

      if crt_pos - 1 <= x and x <= crt_pos + 1 do
        crt <> "#"
      else
        crt <> "."
      end
    end)
    |> String.graphemes()
    |> Enum.chunk_every(40)
    |> Enum.join("\n")
    |> then(&(&1 <> "\n"))
  end

  defp x_values(instructions) do
    instructions
    |> Enum.flat_map(&expand_instruction/1)
    |> Enum.scan(1, fn instruction, x ->
      case instruction do
        :noop -> x
        {:addx, n} -> n + x
      end
    end)
  end

  defp expand_instruction(:noop), do: [:noop]
  defp expand_instruction({:addx, n}), do: [:noop, {:addx, n}]

  def parse(raw) do
    raw
    |> Parser.parse_list(fn line ->
      case line do
        "noop" ->
          :noop

        addx ->
          int =
            String.split(addx, " ")
            |> List.last()
            |> String.to_integer()

          {:addx, int}
      end
    end)
  end
end
