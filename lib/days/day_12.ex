defmodule Advent2022.Days.Day12 do
  use Advent2022.Day

  alias Advent2022.{Grid, Vec2D}

  def part_one(input) do
    {start, finish, grid} = normalize(input)

    distance_map = dijkstra(grid, MapSet.new(), %{start => {0, start}})

    distance_map
    |> Enum.map(fn {c, _} -> c end)
    |> Enum.map(fn c -> Grid.at(grid, c) end)
    |> Enum.max()

    {distance, _source} = distance_map[finish]
    distance
  end

  def part_two(input) do
    {_start, finish, grid} = normalize(input)

    starts =
      grid.data
      |> Enum.filter(fn {_coord, value} -> value == 0 end)
      |> Enum.map(fn {coord, _} -> coord end)

    Enum.map(starts, fn start ->
      distance_map = dijkstra(grid, MapSet.new(), %{start => {0, start}})

      distance_map
      |> Enum.map(fn {c, _} -> c end)
      |> Enum.map(fn c -> Grid.at(grid, c) end)
      |> Enum.max()

      case distance_map[finish] do
        nil -> 9_999_999_999_999
        {0, _} -> 999_999_999_999_999
        {distance, _source} -> distance
      end
    end)
    |> Enum.min()
  end

  def path(_, from, from), do: []

  def path(distance_map, from, to) do
    {_distance, source} = distance_map[from]
    [source | path(distance_map, source, to)]
  end

  defp dijkstra(grid, visited, distance_map) do
    start =
      distance_map
      |> Enum.reject(fn {coord, _} -> MapSet.member?(visited, coord) end)
      |> Enum.min_by(fn {_coord, {distance, _source}} -> distance end, fn -> nil end)

    case start do
      nil ->
        distance_map

      {start, {distance_to_here, _source}} ->
        raw_neighbors_coords =
          Vec2D.nondiagonal_unit_vectors()
          |> Enum.map(&Vec2D.add(&1, start))

        start_value = Grid.at(grid, start)

        neighbors =
          Enum.reduce(raw_neighbors_coords, [], fn coord, neighbors ->
            case Grid.at(grid, coord) do
              :invalid_coord ->
                neighbors

              value when value - start_value <= 1 ->
                [coord | neighbors]

              _value ->
                neighbors
            end
          end)

        distance_map =
          Enum.reduce(neighbors, distance_map, fn neighbor, distance_map ->
            {_v, map} =
              Map.get_and_update(distance_map, neighbor, fn current_value ->
                case current_value do
                  nil ->
                    if neighbor == {5, 2} do
                    end

                    {current_value, {distance_to_here + 1, start}}

                  {prev_distance, _source} ->
                    if distance_to_here + 1 < prev_distance do
                      if neighbor == {5, 2} do
                      end

                      {current_value, {distance_to_here + 1, start}}
                    else
                      {current_value, current_value}
                    end
                end
              end)

            map
          end)

        dijkstra(grid, MapSet.put(visited, start), distance_map)
    end
  end

  defp normalize(input) do
    {start, _} = Enum.find(input.data, fn {_coord, value} -> value == :me end)
    {finish, _} = Enum.find(input.data, fn {_coord, value} -> value == :goal end)

    new_grid =
      input
      |> Grid.put(start, 0)
      |> Grid.put(finish, 25)

    {start, finish, new_grid}
  end

  def parse(raw) do
    raw
    |> Parser.parse_grid(fn letter ->
      [ascii] = String.to_charlist(letter)

      cond do
        ascii in ?a..?z ->
          ascii - ?a

        letter == "E" ->
          :goal

        letter == "S" ->
          :me
      end
    end)
    |> Grid.new()
  end
end
