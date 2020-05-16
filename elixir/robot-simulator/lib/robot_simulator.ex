defmodule RobotSimulator do
  import RobotValidator

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    robot = %RobotSimulator.Robot{direction: direction, position: position}

    case validate_robot(robot) do
      {:ok, robot} -> robot
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  simulate robot instructions as a string of valid characters
  return robot with changed direction and positions given the instructions.

  Valid characters are "A", "L", and "R"
  """

  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) when instructions == "" do
    robot
  end

  def simulate(robot, instructions) do
    instruction = String.first(instructions)
    nextInstructions = String.slice(instructions, 1..-1)

    case instruct(robot, instruction) do
      {:ok, robot} -> simulate(robot, nextInstructions)
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  return a new robot after performing one instruction
  """
  def instruct(_robot, instruction) when instruction not in ["A", "R", "L"] do
    {:error, "invalid instruction"}
  end

  def instruct(robot, instruction) do
    robot = case String.first(instruction) do
      "R" -> turn_right(robot)
      "L" -> turn_left(robot)
      "A" -> advance(robot)
    end
    {:ok, robot}
  end

  @doc """
  turn the robots direction right
  """
  def turn_right(%RobotSimulator.Robot{direction: oldDirection} = robot) do
    newDirection =
      case oldDirection do
        :north -> :east
        :east -> :south
        :south -> :west
        :west -> :north
      end

    %RobotSimulator.Robot{robot | direction: newDirection}
  end

  @doc """
  turn the robots direction left
  """
  def turn_left(%RobotSimulator.Robot{direction: oldDirection} = robot) do
    newDirection =
      case oldDirection do
        :north -> :west
        :west -> :south
        :south -> :east
        :east -> :north
      end

    %RobotSimulator.Robot{robot | direction: newDirection}
  end

  @doc """
  advanced the robots position based on it's direction
  """
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
