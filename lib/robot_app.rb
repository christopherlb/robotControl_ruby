
require_relative 'io_proxy'

class RobotApp
  def initialize(io: IOProxy.new)
    @io = io

    # Position (0,0) on the grid is the south west corner
    @x = 0
    @y = 0
    @orientation = "E"
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
    @x = match[1].to_i
    @y = match[2].to_i
    @orientation = match[3].upcase
  end

  def handle_report
    @io.puts("#{@x},#{@y},#{@orientation}")
  end

  def handle_move
    case @orientation
    when "E"
      @x += 1
    when "W"
      @x -= 1
    when "N"
      @y += 1
    when "S"
      @y -= 1
    else
      raise "Unknown orientation"
    end
  end
end
