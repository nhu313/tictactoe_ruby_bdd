require 'tictactoe/strategy/user_strategy'

describe TicTacToe::UserStrategy do
  
  before(:each) do
    @board = mock().as_null_object
    @input = mock().as_null_object
    @output = mock().as_null_object
    @strategy = TicTacToe::UserStrategy.new(@input, @output, @board)
  end
  
  context "gets user move" do
    # Can I write this better?
    it "prompts the user for a move" do 
      @output.should_receive(:puts).with("Please enter a square number that is not marked: ")
      move = "2"
      @input.should_receive(:gets).and_return(move)
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