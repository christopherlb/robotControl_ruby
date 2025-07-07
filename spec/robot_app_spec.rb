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
    end.new(StringIO.new(input), output)
  end

  let(:app) { RobotApp.new(io: io_proxy) }

  before do
    app.run
    output.rewind
  end

  describe "the input is just 'quit'" do
    let(:input) { "quit\n" }
    it "greets the user on start" do
      expect(output.read).to include("Toy robot, waiting for input")
    end
  end

  describe "when the input contains unknown stuff" do
    let(:input) { "fooo\nquitll\nquit\n" }
    it "is tolerant of misformed input" do
      expect(output.read).to include("Toy robot, waiting for input")
    end
  end

  describe "report" do
    describe "when in a default state" do
      let(:input) { "report\nquit\n" }
      it "prints a default position" do
        expect(output.read).to include("Toy robot, waiting for input\n0,0,E")
      end
    end
  end
end
