require 'tictactoe/player/human_player'

describe TicTacToe::HumanPlayer do

  it "gets name" do
    name = "bruce"
    @player = TicTacToe::HumanPlayer.new(Hash[:name => name])
    @player.name.should == name
  end

  it "tests to sym" do
    @player = TicTacToe::HumanPlayer.new(Hash.new)
    @player.to_sym.should == :human_player
  end
  
  context "gets user move" do
    before(:each) do
      @input = StringIO.new
      @output = StringIO.new
      @options = Hash[:input => @input, :output => @output]
      @player = TicTacToe::HumanPlayer.new(@options)
    end
    
    it "prompts the user for a move" do 
      @output.should_receive(:puts).with("Please enter a square number that is not marked: ")
      @input.should_receive(:gets).and_return("3")
      @player.move
    end
     
    it "returns a number when user enters a number" do
      move = "2"
      @input.should_receive(:gets).and_return(move)
      @player.move.should == move.to_i
    end
    
    it "asks for user input again when user enter a character" do
      invalid_move = "a"
      valid_move = "2"
      @input.should_receive(:gets).and_return(invalid_move, invalid_move, valid_move)
      @output.should_receive(:puts).with("Please enter a square number that is not marked: ").at_least(2).times
      @player.move.should == valid_move.to_i
    end
  end
  
end