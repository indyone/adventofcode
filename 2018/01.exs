defmodule Day01 do
  @input "01.input"
         |> File.read!()
         |> String.split()
         |> Enum.map(&Integer.parse(&1))
         |> Enum.map(&elem(&1, 0))

  @start 0

  # @input [+7, +7, -2, -7, -4]

  def find(), do: Enum.reduce(@input, @start, fn n, acc -> n + acc end)

  def find_twice(), do: do_find_twice(@input, [@start])
  def find_twice(input), do: do_find_twice(input, [@start])
  defp do_find_twice([], acc), do: do_find_twice(@input, acc)

  defp do_find_twice([n | input], [a | _] = acc) do
    na = n + a
    if na in acc, do: na, else: do_find_twice(input, [na | acc])
  end
end

IO.puts(
  "Starting with a frequency of zero, what is the resulting frequency " <>
    "after all of the changes in frequency have been applied? #{Day01.find()}"
)

IO.puts("What is the first frequency your device reaches twice? #{Day01.find_twice()}")
