defmodule Solution do
  def of do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.reject(&invalid?/1)
  end

  def valid?(str) do
    array = str |> String.split(" ")
    array == Enum.uniq(array)
  end

  def invalid?(str) do
    !valid?(str)
  end
end

ExUnit.start

defmodule SolutionTest do
  use ExUnit.Case

  test "that valid works" do
    assert Solution.valid?("aa bb cc dd ee")
    assert !Solution.valid?("aa bb cc dd aa")
    assert Solution.valid?("aa bb cc dd aaa")
  end
end

IO.inspect Solution.of
