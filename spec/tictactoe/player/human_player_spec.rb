require 'tictactoe/player/human_player'

describe TicTacToe::HumanPlayer do
  before(:each) do
    @name = "Bruce"
    @value = "X"
    @strategy = mock()
    @player = TicTacToe::HumanPlayer.new(@name, @value, @strategy)
  end
  
  it "name is the value set in the constructor" do
    @player.name.should == @name
  end
  
  it "value is the one set in the constructor" do
    @player.value.should == @value
  end
  
  it "returns the move set by the strategy" do
    move = 4
    @strategy.should_receive(:move).and_return(move)

    @player.move.should == move
  end
  
end