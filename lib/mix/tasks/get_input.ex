defmodule Mix.Tasks.GetInput do
  def run([day_no]) do
    {:ok, _} = :application.ensure_all_started(:advent2022)

    day_no = String.to_integer(day_no)
    Advent2022.Inputs.download_input(day_no)
  end
end
