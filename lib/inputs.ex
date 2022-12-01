defmodule Advent2022.Inputs do
  @inputs_dir __DIR__ |> Path.join("inputs")

  def input(day_no) do
    path = input_path(day_no)

    if File.exists?(path) do
      File.read!(path)
    else
      nil
    end
  end

  def input_path(day_no) when is_integer(day_no) do
    @inputs_dir |> Path.join("day_" <> Integer.to_string(day_no) <> ".txt")
  end

end
