defmodule Advent2022.Days.Day9 do
  alias Advent2022.Vec2D
  use Advent2022.Day

  def part_one(input) do
    # H - T gives vector pointing to H, if magnitude > 1, normalize and move T
    input
    |> simulate_rope(2)
  end

  def part_two(input) do
    input
    |> simulate_rope(10)
  end

  defp simulate_rope(instructions, rope_length) do
    instructions
    |> flatten_instructions()
    |> Enum.reduce(
      %{head: {0, 0}, tails: for(_ <- 1..(rope_length - 1), do: {0, 0}), tail_set: MapSet.new()},
      fn direction,
         %{
           head: head,
           tails: tails,
           tail_set: tail_set
         } ->
        new_head = Vec2D.add(head, direction)

        {_, new_tails} =
          Enum.reduce(tails, {new_head, []}, fn tail, {head, tails} ->
            steering = Vec2D.subtract(head, tail)

            new_tail =
              if trunc(Vec2D.magnitude(steering)) > 1 do
                {sx, sy} = steering
                Vec2D.add(tail, {clamp(sx, -1, 1), clamp(sy, -1, 1)})
              else
                tail
              end

            {new_tail, [new_tail | tails]}
          end)

        new_tails = Enum.reverse(new_tails)

        %{
          head: new_head,
          tails: new_tails,
          tail_set: MapSet.put(tail_set, List.last(new_tails))
        }
      end
    )
    |> then(fn %{tail_set: tail_set} -> Enum.count(tail_set) end)
  end

  def debug_grid(head, tail, visited) do
    combo = [head | tail] ++ Enum.to_list(visited)
    xs = Enum.map(combo, fn {x, _} -> x end)
    ys = Enum.map(combo, fn {_, y} -> y end)
    min_x = Enum.min(xs)
    max_x = Enum.max(xs)
    min_y = Enum.min(ys)
    max_y = Enum.max(ys)

    significant_locations = %{
      head => "H",
      {0, 0} => "S"
    }

    tail_locations =
      Enum.with_index(tail, 1)
      |> Enum.map(fn {coord, index} -> {coord, inspect(index)} end)
      |> Enum.into(%{})

    locations = Map.merge(tail_locations, significant_locations)

    for y <- min_y..max_y do
      min_x..max_x
      |> Enum.map(&Map.get(locations, {&1, y}, "."))
      |> Enum.join()
    end
    |> Enum.join("\n")
    |> then(&("\n" <> &1 <> "\n"))
  end

  defp flatten_instructions(instructions) do
    Enum.flat_map(instructions, fn {direction, steps} ->
      for _ <- 1..steps, do: direction
    end)
  end

  defp clamp(num, min, max) do
    num |> max(min) |> min(max)
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(fn instruction ->
      [direction, steps] = String.split(instruction, " ", trim: true)
      steps = String.to_integer(steps)

      case direction do
        "R" -> {{1, 0}, steps}
        "L" -> {{-1, 0}, steps}
        "U" -> {{0, -1}, steps}
        "D" -> {{0, 1}, steps}
      end
    end)
  end
end
