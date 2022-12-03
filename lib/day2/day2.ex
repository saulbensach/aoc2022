defmodule Aoc.Day2.Part2 do
  @rules %{"A" => "C", "C" => "B", "B" => "A"}
  @reversed_rules %{"C" => "A", "B" => "C", "A" => "B"}
  @scores %{"A" => 1, "B" => 2, "C" => 3}
  @draw_score 3
  @win_score 6

  def run() do
    "lib/day2/input.txt"
    |> File.read!()
    |> String.split(["\n", "\r"], trim: true)
    |> Enum.reduce(0, fn round, score ->
      [player_move, strat] = String.split(round, " ")

      score + calc_score(player_move, strat)
    end)
  end

  def calc_score(player_move, "X"), do: shape_score(@rules[player_move])
  def calc_score(player_move, "Y"), do: shape_score(player_move) + @draw_score
  def calc_score(player_move, "Z"), do: shape_score(@reversed_rules[player_move]) + @win_score

  def shape_score(move), do: Map.get(@scores, move)
end
