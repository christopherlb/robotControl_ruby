require 'stringio'

RSpec.describe RobotApp do
  let(:output) { StringIO.new }
  let(:io_proxy) do
    input_string = input.append("quit").join("\n")
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
    end.new(StringIO.new(input_string), output)
  end

  let(:app) { RobotApp.new(io: io_proxy) }

  before do
    app.run
    output.rewind
  end

  describe "instructions One" do
    let(:input) { ["PLACE 0,0,E", "MOVE", "REPORT"] }
    it "Output: 1,0,E" do
      expect(output.read).to include("1,0,E")
    end
  end

  describe "instructions Two" do
    let(:input) { ["PLACE 0,0,N", "MOVE", "MOVE", "RIGHT", "MOVE", "REPORT"] }
    it "Output: 1,2,E" do
      expect(output.read).to include("1,2,E")
    end
  end
end
