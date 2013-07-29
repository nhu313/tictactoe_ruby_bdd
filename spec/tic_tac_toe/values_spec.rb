require 'tic_tac_toe/values'

describe "Values" do
  VALUES = ["X", "O"]

  it "has X and O values" do
    TicTacToe::VALUES.should == VALUES
  end

  it "gets opponent for X" do
    TicTacToe::Values.opponent(VALUES[0]).should == VALUES[1]
  end

  it "gets opponent for O" do
    TicTacToe::Values.opponent(VALUES[1]).should == VALUES[0]
  end
end
