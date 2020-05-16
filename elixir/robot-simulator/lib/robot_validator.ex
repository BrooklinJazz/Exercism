defmodule RobotValidator do
  def validate_robot(%RobotSimulator.Robot{direction: direction, position: position} = robot) do
    cond do
      not valid_direction?(direction) -> {:error, "invalid direction"}
      not valid_position?(position) -> {:error, "invalid position"}
      true -> {:ok, robot}
    end
  end

  def valid_instructions?(instructions) do
    String.graphemes(instructions)
    |> Enum.all?(fn each -> Enum.member?(["A", "R", "L"], each) end)
  end

  def valid_instruction?(instruction) do
    Enum.member?(["A", "R", "L"], instruction)
  end

  def valid_direction?(direction) do
    Enum.member?([:north, :south, :west, :east], direction)
  end

  def valid_position?(position) do
    cond do
      not is_tuple(position) -> false
      tuple_size(position) != 2 -> false
      not is_number(elem(position, 0)) -> false
      not is_number(elem(position, 1)) -> false
      true -> true
    end
  end
end
