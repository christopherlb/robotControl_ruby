
require_relative 'io_proxy'

class RobotApp

  module Orientation
    EAST = 0
    SOUTH = 1
    WEST = 2
    NORTH = 3
    ORIENTATION_MAX = 4
  end

  def initialize(io: IOProxy.new)
    @io = io

    @max_x = 6
    @max_y = 6

    # Position (0,0) on the grid is the south west corner
    @x = 0
    @y = 0
    @orientation = Orientation::EAST
  end

  def run
    @io.puts "Toy robot, waiting for input"


    loop do
      # Standardise & ssanitize input
      input = @io.gets&.strip&.downcase

      # Try and perform a command based on the request
      if input == "report"
        handle_report
      end

      match = input&.match(/^place (\d+),(\d+),([nsew])$/i)
      if match
        handle_place(match)
      end

      if input == "move"
        handle_move
      end

      if input == "left"
        handle_rotate(-1)
      end

      if input == "right"
        handle_rotate(1)
      end

      break if input == "quit"
    end
  end

  private

  def handle_place(match)
    o = case match[3]
      when "e"
       Orientation::EAST
      when "w"
       Orientation::WEST
      when "n"
       Orientation::NORTH
      when "s"
       Orientation::SOUTH
      else
       raise "Unknown orientation #{@orientation}"
      end
    x = match[1].to_i
    y = match[2].to_i

    return if out_of_range(x, y)

    @x = x
    @y = y
    @orientation = o
  end

  def out_of_range(x, y)
    if x < 0 or y < 0 or x >= @max_x or y >= @max_y
      # Don't action any part of a command that would put the robot out of bounds
      true
    else
      false
    end
  end

  def handle_report
    orientation_string = case @orientation
    when Orientation::EAST
      "E"
    when Orientation::WEST
      "W"
    when Orientation::NORTH
      "N"
    when Orientation::SOUTH
      "S"
    else
      raise "Unknown orientation #{@orientation}"
    end

    @io.puts("#{@x},#{@y},#{orientation_string}")
  end

  def handle_move
    x = @x
    y = @y
    case @orientation
    when Orientation::EAST
      x += 1
    when Orientation::WEST
      x -= 1
    when Orientation::NORTH
      y += 1
    when Orientation::SOUTH
      y -= 1
    else
      raise "Unknown orientation #{@orientation}"
    end

    return if out_of_range(x, y)
    @x = x
    @y = y
  end

  def handle_rotate(direction)
    @orientation = (@orientation + direction) % Orientation::ORIENTATION_MAX
  end
end
