 require "spec_helper"

RSpec.describe ToyRobot::Simulator do
 let(:table) { ToyRobot::Table.new(5, 5) }
 subject { ToyRobot::Simulator.new(table) }

 it "places the robot onto a valid position" do
   expect(ToyRobot::Robot).to receive(:new)
   .with(0, 0, "NORTH")
   .and_return(double)
   subject.place(0, 0, "NORTH")
   expect(subject.robot).not_to be_nil
 end

 it "cannot place the robot onto an invalid position" do
   expect(ToyRobot::Robot).not_to receive(:new)
   subject.place(5, 5, "NORTH")
   expect(subject.robot).to be_nil
 end

 context 'robot placed at table boundary' do
    before do
      subject.place(0, 4, "NORTH")
    end

    it 'cannot move past the table boundary' do
      subject.move
      message = "Robot is currently at 0, 4 and it's facing NORTH\n"
      expect {subject.report}.to output(message).to_stdout
    end
  end
end
