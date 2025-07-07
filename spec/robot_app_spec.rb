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

    describe "when trying to place out of the board on x" do
      let(:input) { "place 110,0,w\nreport\nquit\n" }
      it "prints a default position" do
        expect(output.read).not_to include("110,0,W")
      end
    end

    describe "when trying to place out of the board on y" do
      let(:input) { "place 0,110,w\nreport\nquit\n" }
      it "prints a default position" do
        expect(output.read).not_to include("0,110,W")
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
      let(:input) { "PLace 1,0,w\nmove\nreport\nquit\n" }
      it "prints a default position" do
        expect(output.read).to include("0,0,W")
      end
    end

    describe "starting up down, facing n" do
      let(:input) { "PLace 0,1,n\nmove\nreport\nquit\n" }
      it "prints a default position" do
        expect(output.read).to include("0,2,N")
      end
    end

    describe "starting one up, facing s" do
      let(:input) { "PLace 0,1,s\nmove\nreport\nquit\n" }
      it "prints a default position" do
        expect(output.read).to include("0,0,S")
      end
    end
  end

  describe "left" do
    describe "when starting facing north" do
      let(:input) { "place 0,0,n\nleft\nreport\nquit\n" }
      it "orients west" do
        expect(output.read).to include("0,0,W")
      end
    end
  end

  describe "right" do
    describe "when starting facing north" do
      let(:input) { "place 0,0,n\nright\nreport\nquit\n" }
      it "orients east" do
        expect(output.read).to include("0,0,E")
      end
    end
  end
end
