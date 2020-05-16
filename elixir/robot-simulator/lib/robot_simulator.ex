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
    cond do
      not is_tuple(position) -> false
      tuple_size(position) != 2 -> false
      not is_number(elem(position, 0)) -> false
      not is_number(elem(position, 1)) -> false
      true -> true
    end
  end

  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instruction = String.first(instructions)

    cond do
      String.length(instructions) == 0 ->
        robot

      not valid_instruction?(instruction) ->
        {:error, "invalid instruction"}

      true ->
        instruct(robot, instruction) |> simulate(String.slice(instructions, 1..-1))
    end
  end

  def instruct(robot, instruction) do
    case String.first(instruction) do
      "R" -> turn_right(robot)
      "L" -> turn_left(robot)
      "A" -> advance(robot)
      _ -> {:error, "invalid instruction"}
    end
  end

  def valid_instruction?(instruction) do
    Enum.member?(["A", "R", "L"], instruction)
  end

  defp turn_right(%RobotSimulator.Robot{direction: oldDirection} = robot) do
    newDirection =
      case oldDirection do
        :north -> :east
        :east -> :south
        :south -> :west
        :west -> :north
      end

    %RobotSimulator.Robot{robot | direction: newDirection}
  end

  defp turn_left(%RobotSimulator.Robot{direction: oldDirection} = robot) do
    newDirection =
      case oldDirection do
        :north -> :west
        :west -> :south
        :south -> :east
        :east -> :north
      end

    %RobotSimulator.Robot{robot | direction: newDirection}
  end

  def advance(%RobotSimulator.Robot{position: {x, y}, direction: direction} = robot) do
    pos =
      case direction do
        :north -> {x, y + 1}
        :east -> {x + 1, y}
        :south -> {x, y - 1}
        :west -> {x - 1, y}
      end

    %RobotSimulator.Robot{robot | position: pos}
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
