require 'stringio'

RSpec.describe RobotApp do
  let(:output) { StringIO.new }
  let(:io_proxy) do
    Class.new do
      def initialize(input, output)
        @input = input
        @output = output
      end

      def puts(message)
        @output.puts(message)
      end

      def gets
        @input.gets
      end
    end.new(input, output)
  end

  let(:app) { RobotApp.new(io: io_proxy) }

  before do
    app.run
  end

  describe "the input is just 'quit'" do
    let(:input) { StringIO.new("quit\n") }
    it "greets the user on start" do
      output.rewind
      expect(output.read).to include("Toy robot, waiting for input")
    end
  end

  describe "when the input contains unknown stuff" do
    let(:input) { StringIO.new("fooo\nquitll\nquit\n") }
    it "is tolerant of misformed input" do
      output.rewind
      expect(output.read).to include("Toy robot, waiting for input")
    end
  end
end
