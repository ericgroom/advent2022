defmodule Advent2022.Grid do
  defstruct [:data]

  alias __MODULE__

  def new() do
    %Grid{data: %{}}
  end

  def new(coord_map) when is_map(coord_map) do
    %Grid{data: coord_map}
  end

  def new(nested_list) when is_list(nested_list) do
    data =
      nested_list
      |> Stream.with_index()
      |> Enum.flat_map(fn {row, row_i} ->
        row
        |> Stream.with_index()
        |> Stream.map(fn {cell, col_i} ->
          {{col_i, row_i}, cell}
        end)
      end)
      |> Enum.into(%{})

    %Grid{data: data}
  end

  def at(%Grid{} = grid, {_x, _y} = coord) do
    Map.get(grid.data, coord, :invalid_coord)
  end

  def equals?(%Grid{data: data_one}, %Grid{data: data_two}) do
    Map.equal?(data_one, data_two)
  end

  def put(%Grid{data: data}, {_x, _y} = coord, value) do
    new_grid = Map.put(data, coord, value)
    %Grid{data: new_grid}
  end

  def coords(%Grid{data: data}) do
    data |> Map.keys()
  end
end
