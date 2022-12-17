defmodule AOC.Day3 do
  def one() do
    input = load_input()
    priorities = gen_priorities()

    Enum.reduce(input, 0, fn rucksack, acc ->
      {comp1, comp2} = split_rucksack(rucksack)

      items = intersec_compartiments(String.graphemes(comp1), String.graphemes(comp2))

      Enum.reduce(items, 0, &(priorities[&1] + &2)) + acc
    end)
  end

  def two() do
    input = Enum.chunk_every(load_input(), 3)
    priorities = gen_priorities()

    Enum.reduce(input, 0, fn group, acc ->
      [first | rest] = group
      first = String.graphemes(first)

      [item] =
        Enum.reduce(rest, first, fn rucksack, acc ->
          intersec_compartiments(acc, String.graphemes(rucksack))
        end)

      priorities[item] + acc
    end)
  end

  defp split_rucksack(rucksack) do
    len = String.length(rucksack)
    String.split_at(rucksack, div(len, 2))
  end

  defp intersec_compartiments(a, b) do
    set1 = MapSet.new(a)
    set2 = MapSet.new(b)

    MapSet.intersection(set1, set2)
    |> MapSet.to_list()
  end

  defp gen_priorities() do
    dic = for item <- ?a..?z, do: {<<item>>, item}
    dic_up = for item <- ?A..?Z, do: {<<item>>, item}

    reduce = fn letters, offset ->
      Enum.reduce(letters, %{}, fn {letter, index}, acc ->
        Map.put(acc, letter, index - offset)
      end)
    end

    Map.merge(reduce.(dic, 96), reduce.(dic_up, 38))
  end

  defp load_input() do
    "lib/day3/input.txt"
    |> File.read!()
    |> String.split(["\n", "\r"], trim: true)
  end
end
