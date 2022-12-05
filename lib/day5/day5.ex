defmodule AOC.Day5 do

  @init_test %{
    "1" => ["N", "Z"],
    "2" => ["D", "C", "M"],
    "3" => ["P"]
  }

  @init %{
    "1" => ["G", "J", "W", "R", "F", "T", "Z"],
    "2" => ["M", "W", "G"],
    "3" => ["G", "H", "N", "J"],
    "4" => ["W", "N", "C", "R", "J"],
    "5" => ["M", "V", "Q", "G", "B", "S", "F", "W"],
    "6" => ["C", "W", "V", "D", "T", "R", "S"],
    "7" => ["V", "G", "Z", "D", "C", "N", "B", "H"],
    "8" => ["C", "G", "M", "N", "J", "S"],
    "9" => ["L", "D", "J", "C", "W", "N", "P", "G"]
  }

  def one() do
    run(&move_from_to/4)
  end

  def two() do
    run(&move_from_to_kekw/4)
  end

  defp run(fun) do
    Enum.reduce(open_and_prep_file(), @init, fn {move, from, to}, acc ->
      fun.(move, from, to, acc)
    end)
    |> Enum.map(fn {_k, [h | _]} -> h end)
    |> Enum.join()
  end

  # Literally same for part 1 and two, just changes enum reverse of taken
  # just duplicate as im lazy
  defp move_from_to(move, from, to, map) do
    list = map[from]
    {taken, rest} = Enum.split(list, move)

    map
    |> update_in([from], fn _ -> rest end)
    |> update_in([to], fn list -> List.flatten([Enum.reverse(taken) | list]) end)
  end

  defp move_from_to_kekw(move, from, to, map) do
    list = map[from]
    {taken, rest} = Enum.split(list, move)

    map
    |> update_in([from], fn _ -> rest end)
    |> update_in([to], fn list -> List.flatten([taken | list]) end)
  end

  defp open_and_prep_file() do
    "lib/day5/input.txt"
    |> File.read!()
    |> String.split(["\n", "\r"], trim: true)
    |> Enum.map(fn command ->
      [_, move, _, from, _, to] = String.split(command, " ", trim: true)

      {String.to_integer(move), from, to}
    end)
  end
end
