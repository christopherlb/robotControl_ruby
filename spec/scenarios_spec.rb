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

  describe "Multiple reports" do
    let(:input) { ["PLACE 0,0,N", "MOVE", "MOVE", "RIGHT", "MOVE", "REPORT", "MOVE", "REPORT"] }
    it "outputs them both on separate lines" do
      expect(output.read).to include("1,2,E\n2,2,E")
    end
  end

  describe "Re-place" do
    let(:input) { ["PLACE 0,0,N", "MOVE", "MOVE", "PLACE 0,0,N", "RIGHT", "MOVE", "REPORT"] }
    it "follows instructions according to new start" do
      expect(output.read).to include("1,0,E")
    end
  end

  describe "Invalid commands" do
    let(:input) { ["PLACE 0,0,N", "MOVE", "MOVNE", "RIGHT", "MOVE", "REPORT"] }
    it "are ignored" do
      expect(output.read).to include("1,1,E")
    end
  end

  describe "Out of grid movements" do
    let(:input) do
      ["PLACE 0,0,E",
       "MOVE", "MOVE", "MOVE", "MOVE", "MOVE", "MOVE", "MOVE",
       "LEFT",
       "MOVE", "MOVE", "MOVE", "MOVE", "MOVE", "MOVE", "MOVE",
       "RIGHT",
       "REPORT"]
    end
    it "are ignored" do
      expect(output.read).to include("5,5,E")
    end
  end

  describe "donuts" do
    let(:input) { ["PLACE 0,0,E", "RiGHT", "RiGHT", "RiGHT", "RiGHT", "REPORT"] }
    it "result in the original orientation" do
      expect(output.read).to include("0,0,E")
    end
  end

  describe "input is substantially in Chinese characters" do
    let(:input) { ["地点 三,二,东", "report"] }
    it "does not crash, and displays a message" do
      expect(output.read).to include("Not placed yet")
    end
  end
end
