require 'spec_helper'

RSpec.describe ToyRobot::CLI do
  subject { ToyRobot::CLI.new }

  before do
    allow(subject).to receive (:simulator) { simulator }
  end

  context "place command" do
    let(:simulator) { instance_double(ToyRobot::Simulator) }
    it "passes a place command to the simulator" do
      expect(simulator).to receive(:place).with(0, 0, "NORTH")
      subject.run([[:place, 0, 0, "NORTH"]])
    end
  end

  context "move command" do
    let(:simulator) { instance_double(ToyRobot::Simulator) }
    it "passes the command to the simulator" do
      expect(simulator).to receive(:move)
      subject.run([[:move]])
    end
  end

  context "load_commands" do
    before do
      allow(subject).to receive (:simulator) { simulator }
    end

    it "loads commands from a file" do
      path = File.dirname(__FILE__) + "/../fixtures/commands.txt"
      commands = subject.load_commands(path)

      expect(commands).to eq([
        [:place, 0, 0, "NORTH"],
        [:move],
        [:turn_right],
        [:turn_left],
        [:report]
      ])
    end
  end
end
