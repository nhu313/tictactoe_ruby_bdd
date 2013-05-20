require 'tictactoe/strategy/minimax_strategy'

describe TicTacToe::MinimaxStrategy do
  
  context "1x1 board" do
    it "is 0"
  end
  
  context "2x2 board" do
    it "is the winning move when player goes first"
  end
  
  context "3x3 board" do
    it "is the winning move when it is available"
    
    it "is the blocking move when there is no winning move and other player could win"
    
    
  end
  
end