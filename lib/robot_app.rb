
require_relative 'io_proxy'

class RobotApp
  def initialize(io: IOProxy.new)
    @io = io
  end

  def run
    @io.puts "Toy robot, waiting for input"

    loop do
      input = @io.gets&.strip
      break if input&.downcase == "quit"
    end
  end
end
