defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    cond do
      not valid_direction?(direction) -> {:error, "invalid direction"}
      not valid_position?(position) -> {:error, "invalid position"}
      true -> %RobotSimulator.Robot{direction: direction, position: position}
    end
  end

  def valid_direction?(direction) do
    Enum.member?([:north, :south, :west, :east], direction)
  end

  def valid_position?(position) do

    # // TODO REFACTOR
    cond do
      not is_tuple(position) -> false
      tuple_size(position) != 2 -> false
      not is_number elem(position, 0) -> false
      not is_number elem(position, 1) -> false
      true -> true
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """

  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    cond do
      String.length(instructions) == 0 ->
        robot

      true ->
        instruct(robot, String.first(instructions)) |> simulate(String.slice(instructions, 1..-1))
    end
  end

  def instruct(
        %RobotSimulator.Robot{direction: direction, position: position} = robot,
        instruction
      ) do
    case String.first(instruction) do
      "R" -> %RobotSimulator.Robot{robot | direction: turn_right(direction)}
      "L" -> %RobotSimulator.Robot{robot | direction: turn_left(direction)}
      "A" -> %RobotSimulator.Robot{robot | position: advance(position, direction)}
    end
  end

  # TODO refactor turn_right, turn_left, and advance to also take a robot.
  def turn_right(direction) do
    case direction do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
  end

  def turn_left(direction) do
    case direction do
      :north -> :west
      :west -> :south
      :south -> :east
      :east -> :north
    end
  end

  def advance({x, y}, direction) do
    case direction do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%RobotSimulator.Robot{direction: direction}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%RobotSimulator.Robot{position: position}) do
    position
  end
end
