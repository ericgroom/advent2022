defmodule Advent2022.Days.Day9 do
  alias Advent2022.Vec2D
  use Advent2022.Day

  def part_one(input) do
    # H - T gives vector pointing to H, if magnitude > 1, normalize and move T
    input
    |> flatten_instructions()
    |> Enum.reduce(%{head: {0, 0}, tail: {0, 0}, tail_set: MapSet.new()}, fn direction,
                                                                             %{
                                                                               head: head,
                                                                               tail: tail,
                                                                               tail_set: tail_set
                                                                             } ->
      new_head = Vec2D.add(head, direction)
      steering = Vec2D.subtract(new_head, tail)

      new_tail =
        if trunc(Vec2D.magnitude(steering)) > 1 do
          {sx, sy} = steering
          Vec2D.add(tail, {clamp(sx, -1, 1), clamp(sy, -1, 1)})
        else
          tail
        end

      %{head: new_head, tail: new_tail, tail_set: MapSet.put(tail_set, new_tail)}
    end)
    |> then(fn %{tail_set: tail_set} -> Enum.count(tail_set) end)
  end

  def part_two(input) do
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
