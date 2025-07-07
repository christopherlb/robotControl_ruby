
require_relative 'io_proxy'

class RobotApp

  module Orientation
    EAST = 1
    SOUTH = 2
    WEST = 3
    NORTH = 4
    ORIENTATION_MAX = 5
  end

  def initialize(io: IOProxy.new)
    @io = io

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
    @x = match[1].to_i
    @y = match[2].to_i
    @orientation = o
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
    case @orientation
    when Orientation::EAST
      @x += 1
    when Orientation::WEST
      @x -= 1
    when Orientation::NORTH
      @y += 1
    when Orientation::SOUTH
      @y -= 1
    else
      raise "Unknown orientation #{@orientation}"
    end
  end
end
