defmodule AOC.Day7 do
  def one() do
    prepare()
    |> Map.filter(fn {_, v} -> v <= 100_000 end)
    |> Map.values()
    |> Enum.sum()
  end

  def two() do
    total_disk = 70_000_000
    required_space = 30_000_000

    dirs = prepare()

    free = total_disk - dirs[["/"]]
    to_claim = required_space - free

    dirs
    |> Map.values()
    |> Enum.filter(fn v -> v >= to_claim end)
    |> Enum.min()
  end

  defp prepare() do
    "lib/day7/input.txt"
    |> File.stream!()
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Stream.filter(&(&1 != "$ ls"))
    |> Stream.reject(&String.contains?(&1, "dir"))
    |> Enum.to_list()
    |> reduce_path([], %{})
  end

  defp reduce_path([], _path, acc) do
    acc
  end

  defp reduce_path([line | rest], path, acc) do
    path =
      case line do
        "$ cd .." ->
          tl(path)

        "$ cd " <> dir ->
          [dir | path]

        _ ->
          path
      end

    acc =
      case Integer.parse(line) do
        {value, _} ->
          traverse_sizes(value, path, acc)

        _ ->
          acc
      end

    reduce_path(rest, path, acc)
  end

  defp traverse_sizes(_value, [], acc) do
    acc
  end

  defp traverse_sizes(value, path, acc) do
    updated_acc = Map.update(acc, path, value, &(&1 + value))

    if path == [] do
      updated_acc
    else
      traverse_sizes(value, tl(path), updated_acc)
    end
  end
end
