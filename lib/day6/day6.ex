defmodule AOC.Day6 do
  def one(), do: count_chars_until_marker(4)

  def two(), do: count_chars_until_marker(14)

  def count_chars_until_marker(char_count) do
    "lib/day6/input.txt"
    |> File.read!()
    |> String.graphemes()
    |> Enum.reduce_while({[], 0}, fn
      char, {acc, iter} when length(acc) < char_count ->
        {:cont, {[char | acc], iter + 1}}

      char, {acc, iter} ->
        unique_vals = Enum.uniq(acc)

        if length(acc) == length(unique_vals) do
          {:halt, iter}
        else
          {:cont, {[char | Enum.take(acc, char_count - 1)], iter + 1}}
        end
    end)
  end
end
