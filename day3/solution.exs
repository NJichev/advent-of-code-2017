# 17  16  15  14  13
# 18   5   4   3  12
# 19   6   1   2  11
# 20   7   8   9  10
# 21  22  23---> ...
defmodule Solution do
  import Integer
  alias :math, as: Math

  def of(1), do: 0
  def of(input) do
    (low..high) = range(input)
    sq = high |> Math.pow(0.5) |> round
    step = div(sq, 2)

    {x, _} = step..(-step + 1) |> Stream.cycle |> Enum.take(high - low) |> Enum.map(&abs/1) |> Enum.zip(high..low) |> Enum.find(fn {_, n} -> n == input end)
    step + x
  end

  def range(input) do
    upper = input |> Math.pow(0.5) |> round |> Kernel.+(3)
    step = (1..upper)
    |> Enum.filter(fn x -> is_odd(x) end)
    |> Enum.find(fn x -> x * x >= input end)

    low = (step - 2) |> Math.pow(2) |> round |> Kernel.+(1)
    high = step |> Math.pow(2) |> round
    low..high
  end
end

ExUnit.start

defmodule SolutionTest do
  use ExUnit.Case, async: true
  import Solution

  test "that range works" do
    assert range(8) == (2..9)
    assert range(12) == (10..25)
    assert range(21) == (10..25)
    assert range(30) == (26..49)
    assert range(1024) == (962..1089)
  end

  test "that it works" do
    assert Solution.of(1) == 0
    assert Solution.of(12) == 3
    assert Solution.of(21) == 4
    assert Solution.of(23) == 2
    assert Solution.of(1024) == 31
  end
end
