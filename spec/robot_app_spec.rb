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
        expect(output.read).to include("0,0,E")
      end
    end
  end

  describe "place" do
    describe "matches the default" do
      let(:input) { "PLace 0,0,E\nreport\nquit\n" }
      it "prints a default position" do
        expect(output.read).to include("0,0,E")
      end
    end

    describe "is not the default" do
      let(:input) { "PLace 1,2,w\nreport\nquit\n" }
      it "prints a default position" do
        expect(output.read).to include("1,2,W")
      end
    end
  end

  describe "move" do
    describe "default start" do
      let(:input) { "move\nreport\nquit\n" }
      it "prints a default position" do
        expect(output.read).to include("1,0,E")
      end
    end

    describe "starting one over" do
      let(:input) { "PLace 1,0,E\nmove\nreport\nquit\n" }
      it "prints a default position" do
        expect(output.read).to include("2,0,E")
      end
    end

    describe "starting one over, facing w" do
      let(:input) { "PLace 1,0,w\nreport\nquit\n" }
      it "prints a default position" do
        expect(output.read).to include("0,0,W")
      end
    end
  end
end
