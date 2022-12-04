defmodule AOC.Day4 do
  @moduledoc false

  def one() do
    Enum.reduce(read_input(), 0, fn pairs, acc ->
      [a, b] = String.split(pairs, ",")

      a_list = to_integer_list(a)
      b_list = to_integer_list(b)

      biggest_size = biggest_size(a_list, b_list)

      joined_lists = join(a_list, b_list)

      # if list joined did not grow in size, then one range included the other
      if Enum.count(joined_lists) == biggest_size, do: acc + 1, else: acc
    end)
  end

  def two() do
    Enum.reduce(read_input(), 0, fn pairs, acc ->
      [a, b] = String.split(pairs, ",")

      a_list = to_integer_list(a)
      b_list = to_integer_list(b)

      # if total of both lists is less than joined
      # then something was overlaping
      total = Enum.count(a_list) + Enum.count(b_list)

      joined_lists = join(a_list, b_list)

      if Enum.count(joined_lists) < total, do: acc + 1, else: acc
    end)
  end

  defp join(a, b) do
    a = MapSet.new(a)
    b = MapSet.new(b)

    MapSet.union(a, b)
  end

  defp to_integer_list(range) do
    [a, b] = String.split(range, "-")
    a = String.to_integer(a)
    b = String.to_integer(b)

    for i <- a..b, do: i
  end

  defp biggest_size(a, b) do
    max(Enum.count(a), Enum.count(b))
  end

  defp read_input() do
    "lib/day4/input.txt"
    |> File.read!()
    |> String.split(["\n", "\r"], trim: true)
  end
end
