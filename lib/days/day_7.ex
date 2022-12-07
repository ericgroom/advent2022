defmodule Advent2022.Days.Day7 do
  use Advent2022.Day

  def part_one(input) do
    file_tree = compute_tree(input, %{}, [])

    directory_sizes(file_tree)
    |> Enum.map(fn {_, size} -> size end)
    |> Enum.filter(&(&1 <= 100_000))
    |> Enum.sum()
  end

  def part_two(input) do
    total_space = 70_000_000
    update_size = 30_000_000
    file_tree = compute_tree(input, %{}, [])

    sizes = directory_sizes(file_tree)
    %{{[], "/"} => root_size} = sizes
    free_space = total_space - root_size
    deficit = update_size - free_space
    if deficit <= 0, do: raise("no need to remove anything!")

    sizes
    |> Enum.map(fn {_, size} -> size end)
    |> Enum.sort()
    |> Enum.find(fn size -> size - deficit >= 0 end)
  end

  defp directory_sizes(tree, path \\ []) do
    Enum.reduce(tree, %{}, fn {name, file}, sizes ->
      case file do
        file when is_map(file) ->
          size = size_of_directory(file)

          sub_sizes = directory_sizes(file, [name | path])

          Map.put(sizes, {path, name}, size) |> Map.merge(sub_sizes)

        _ ->
          sizes
      end
    end)
  end

  defp size_of_directory(tree) do
    Enum.map(tree, fn {name, file} ->
      case file do
        file when is_map(file) ->
          size_of_directory(tree[name])

        file when is_integer(file) ->
          file
      end
    end)
    |> Enum.sum()
  end

  defp compute_tree([], tree, _dir_stack), do: %{"/" => tree}

  defp compute_tree([{:cd, "/"} | rest], tree, _stack), do: compute_tree(rest, tree, [])

  defp compute_tree([{:cd, ".."} | rest], tree, [_popped | stack]),
    do: compute_tree(rest, tree, stack)

  defp compute_tree([{:cd, dir} | rest], tree, stack), do: compute_tree(rest, tree, [dir | stack])

  defp compute_tree([:ls | rest], tree, dir_stack) do
    files = files_and_dirs(rest)
    new_rest = Enum.drop(rest, Enum.count(files))

    new_tree =
      Enum.reduce(files, tree, fn file, tree ->
        case file do
          {:dir, name} ->
            path = Enum.reverse(dir_stack)

            if path == [] do
              Map.put(tree, name, %{})
            else
              update_in(tree, path, &Map.put(&1, name, %{}))
            end

          {:file, size, name} ->
            path = Enum.reverse(dir_stack)

            if path == [] do
              Map.put(tree, name, size)
            else
              update_in(tree, path, &Map.put(&1, name, size))
            end
        end
      end)

    compute_tree(new_rest, new_tree, dir_stack)
  end

  defp files_and_dirs(lines) do
    Enum.take_while(lines, fn line ->
      case line do
        {:dir, _} ->
          true

        {:file, _, _} ->
          true

        _ ->
          false
      end
    end)
  end

  def parse(raw) do
    raw
    |> Parser.parse_list(&parse_line/1)
  end

  defp parse_line(line) do
    cond do
      String.starts_with?(line, "$") ->
        parse_command(line)

      Integer.parse(line) != :error ->
        parse_file(line)

      String.starts_with?(line, "dir") ->
        parse_dir(line)
    end
  end

  defp parse_command(line) do
    command_raw = String.replace_leading(line, "$ ", "")

    cond do
      String.starts_with?(command_raw, "cd") ->
        [_, dir] = String.split(command_raw, " ")
        {:cd, dir}

      command_raw == "ls" ->
        :ls
    end
  end

  defp parse_file(line) do
    [size, name] = String.split(line, " ", trim: true)
    {:file, String.to_integer(size), name}
  end

  defp parse_dir(line) do
    {:dir, String.replace_leading(line, "dir ", "")}
  end
end
