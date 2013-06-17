require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/strategy/human'

describe TicTacToe::Strategy::Human do

  context "gets move" do
    before(:each) do
      @input = StringIO.new
      @output = StringIO.new
      @strategy = TicTacToe::Strategy::Human.new(@input, @output)
    end

    it "prompts the user for a move" do
      @output.should_receive(:puts).with("Please enter a square number that is not marked: ")
      @input.should_receive(:gets).and_return("3")
      @strategy.move
    end

    it "returns a number when user enters a number" do
      move = "2"
      @input.should_receive(:gets).and_return(move)
      @strategy.move.should == move.to_i
    end

    it "asks for user input again when user enter a character" do
      invalid_move = "a"
      valid_move = "2"
      @input.should_receive(:gets).and_return(invalid_move, invalid_move, valid_move)
      @output.should_receive(:puts).with("Please enter a square number that is not marked: ").at_least(2).times
      @strategy.move.should == valid_move.to_i
    end
  end

end
