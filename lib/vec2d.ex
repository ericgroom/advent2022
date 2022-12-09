defmodule Advent2022.Vec2D do
  def add({x1, y1}, {x2, y2}), do: {x1 + x2, y1 + y2}

  def subtract({x1, y1}, {x2, y2}), do: {x1 - x2, y1 - y2}

  def diagonal_unit_vectors() do
    [{0, -1}, {1, -1}, {1, 0}, {1, 1}, {0, 1}, {-1, 1}, {-1, 0}, {-1, -1}]
  end

  def nondiagonal_unit_vectors() do
    [{0, -1}, {1, 0}, {0, 1}, {-1, 0}]
  end

  def magnitude({x, y}) do
    :math.sqrt(x * x + y * y)
  end

  def normalize({x, y}) do
    mag = magnitude({x, y})
    {x / mag, y / mag}
  end
end
