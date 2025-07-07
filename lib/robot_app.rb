
require_relative 'io_proxy'

class RobotApp
  def initialize(io: IOProxy.new)
    @io = io
  end

  def run
    @io.puts "Toy robot, waiting for input"

    x = 0
    y = 0
    orientation = "E"

    loop do
      input = @io.gets&.strip&.downcase
      if input == "report"
        @io.puts("#{x},#{y},#{orientation}")
      end

      match = input&.match(/^place (\d+),(\d+),([nsew])$/i)
      if match
        x = match[1].to_i
        y = match[2].to_i
        orientation = match[3].upcase
      end

      if input == "move"
        x += 1
      end

      break if input == "quit"
    end
  end
end
