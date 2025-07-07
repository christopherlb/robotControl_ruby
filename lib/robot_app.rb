
require_relative 'io_proxy'

class RobotApp
  def initialize(io: IOProxy.new)
    @io = io
  end

  def run
    @io.puts "Toy robot, waiting for input"

    loop do
      input = @io.gets&.strip&.downcase
      if input == "report"
        @io.puts("0,0,E")
      end

      break if input == "quit"
    end
  end
end
