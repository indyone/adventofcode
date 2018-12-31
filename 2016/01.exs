defmodule AdventOfCode2016.Day01 do

  @moduledoc """
  ## Day 1: No Time for a Taxicab

  Santa's sleigh uses a very high-precision clock to guide its movements, and
  the clock's oscillator is regulated by stars. Unfortunately, the stars have
  been stolen... by the Easter Bunny. To save Christmas, Santa needs you to
  retrieve all *fifty stars* by December 25th.

  Collect stars by solving puzzles. Two puzzles will be made available on each
  day in the advent calendar; the second puzzle is unlocked when you complete
  the first. Each puzzle grants *one star*. Good luck!

  You're airdropped near *Easter Bunny Headquarters* in a city somewhere.
  "Near", unfortunately, is as close as you can get - the instructions on the
  Easter Bunny Recruiting Document the Elves intercepted start here, and
  nobody had time to work them out further.

  The Document indicates that you should start at the given coordinates
  (where you just landed) and face North. Then, follow the provided sequence:
  either turn left (`L`) or right (`R`) 90 degrees, then walk forward the given
  number of blocks, ending at a new intersection.

  There's no time to follow such ridiculous instructions on foot, though, so
  you take a moment and work out the destination. Given that you can only
  walk on the [street grid of the city](https://en.wikipedia.org/wiki/Taxicab_geometry), how far is the shortest path to the
  destination?

  For example:

  * Following `R2, L3` leaves you `2` blocks East and `3` blocks North, or `5`
    blocks away.
  * `R2, R2, R2` leaves you `2` blocks due South of your starting position,
    which is `2` blocks away.
  * `R5, L5, R5, R3` leaves you `12` blocks away.

  *How many blocks away* is Easter Bunny HQ?

  ## Part Two

  Then, you notice the instructions continue on the back of the Recruiting
  Document. Easter Bunny HQ is actually at the first location you visit twice.

  For example, if your instructions are `R8, R4, R4, R8`, the first location
  you visit twice is `4` blocks away, due East.

  How many blocks away is the *first location you visit twice*?
  """

  def solve_part_1(input) do
    input
    |> move()
    |> blocks_away()
  end

  defp move(input), do: Enum.reduce(input, {:north, 0, 0}, &move/2)
  defp move("L" <> step, {:north, x, y}),do: {:west, x, y + int(step)}
  defp move("L" <> step, {:west, x, y}),  do: {:south, x - int(step), y}
  defp move("L" <> step, {:south, x, y}),do: {:east, x, y - int(step)}
  defp move("L" <> step, {:east, x, y}),  do: {:north, x + int(step), y}
  defp move("R" <> step, {:north, x, y}),do: {:east, x, y - int(step)}
  defp move("R" <> step, {:east, x, y}),  do: {:south, x - int(step), y}
  defp move("R" <> step, {:south, x, y}),do: {:west, x, y + int(step)}
  defp move("R" <> step, {:west, x, y}),  do: {:north, x + int(step), y}

  defp int(string), do: String.to_integer(string)


end

input = System.argv() |> Enum.join(" ") |> String.split(", ")
AdventOfCode2016.Day01.solve_part_1(input) |> IO.inspect(label: "Part 1")
