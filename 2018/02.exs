defmodule Day02 do
  @input "02.input"
         |> File.read!()
         |> String.split()
         |> Enum.map(&String.split(&1, "", trim: true))

  def twos_threes(id) do
    id
    |> Enum.reduce(%{}, fn c, acc -> Map.update(acc, c, 1, &(&1 + 1)) end)
    |> Enum.reduce({0, 0}, fn
      _, {1, 1} = acc -> acc
      {_, 2}, {0, t} -> {1, t}
      {_, 3}, {t, 0} -> {t, 1}
      _, acc -> acc
    end)
  end

  def checksum() do
    {t2, t3} =
      @input
      |> Enum.map(&twos_threes(&1))
      |> Enum.reduce({0, 0}, fn {a, b}, {c, d} -> {a + c, b + d} end)

    t2 * t3
  end

  def common_letters(), do: do_common_letters(@input)

  defp do_common_letters([]), do: nil
  defp do_common_letters([a | rest]) do
    for b <- rest, c = have_common_letters(a, b, 0, []), do: throw "#{c}"
    do_common_letters(rest)
  catch
    x -> x
  end

  defp have_common_letters([], _, 1, acc), do: Enum.reverse(acc)
  defp have_common_letters([], _, _, _), do: nil
  defp have_common_letters([a | left], [b | right], c, acc) when a == b, do: have_common_letters(left, right, c, [a | acc])
  defp have_common_letters([_ | left], [_ | right], c, acc), do: have_common_letters(left, right, c + 1, acc)
end

IO.puts("What is the checksum for your list of box IDs? #{Day02.checksum}")
IO.puts("What letters are common between the two correct box IDs? #{Day02.common_letters}")
