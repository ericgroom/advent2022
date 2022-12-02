defmodule Advent2022.Days.Day2 do
  use Advent2022.Day

  def part_one(input) do
    input
    |> score()
  end

  def part_two(input) do
    input
    |> Enum.map(fn {theirs, mine} ->
      {theirs,
       case mine do
         # lose
         :rock ->
           case theirs do
             :rock -> :scissors
             :paper -> :rock
             :scissors -> :paper
           end

         # draw
         :paper ->
           case theirs do
             :rock -> :rock
             :paper -> :paper
             :scissors -> :scissors
           end

         # win
         :scissors ->
           case theirs do
             :rock -> :paper
             :paper -> :scissors
             :scissors -> :rock
           end
       end}
    end)
    |> score()
  end

  defp score(plays) do
    plays
    |> Enum.map(fn play ->
      did_win = won?(play)
      {theirs, mine} = play

      score2 =
        case mine do
          :rock -> 1
          :paper -> 2
          :scissors -> 3
        end

      score3 =
        case did_win do
          :tie -> 3
          :win -> 6
          :lost -> 0
        end

      score2 + score3
    end)
    |> Enum.sum()
  end

  def won?({x, x}), do: :tie
  def won?({:rock, :paper}), do: :win
  def won?({:paper, :scissors}), do: :win
  def won?({:scissors, :rock}), do: :win
  def won?({:paper, :rock}), do: :lost
  def won?({:rock, :scissors}), do: :lost
  def won?({:scissors, :paper}), do: :lost

  def parse(raw) do
    raw
    |> Parser.parse_list(fn line ->
      [theirs, mine] =
        String.split(line, " ", trim: true)
        |> Enum.map(fn el ->
          case el do
            "A" -> :rock
            "X" -> :rock
            "B" -> :paper
            "Y" -> :paper
            "C" -> :scissors
            "Z" -> :scissors
          end
        end)

      {theirs, mine}
    end)
  end
end
