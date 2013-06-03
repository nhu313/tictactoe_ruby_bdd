require 'tictactoe/rules'
require 'tictactoe/board'

describe TicTacToe::Rules do
    
  before(:each) do
    @player = "X"
    @opponent = "O"
    @board = TicTacToe::Board.new(3)
    @rules = TicTacToe::Rules.new(@board, [@player, @opponent])
  end
  
  context "game is not over" do
    it "when no one made a move" do
      @rules.should_not be_game_over
    end
    
    it "when there is only one marked square" do
      mark([0], @player)
      @rules.should_not be_game_over
    end
    
    it "when there is no winner and there is one square left" do
      mark((1...@board.size**2).to_a, "i")
      @rules.should_not be_game_over
    end
  end
  
  context "game over when there is a winner" do
    it "when player wins horizontally" do
      mark([0, 1, 2], @player)
      @rules.should be_game_over
    end
    
    it "when player wins vertially" do
      mark([1, 4, 7], @player)
      @rules.should be_game_over
    end
    
    it "when player wins diagonally" do
      mark([2, 4, 6], @player)
      @rules.should be_game_over
    end
    
    it "when opponent wins" do
      mark([0, 4, 8], @opponent)
      @rules.should be_game_over
    end
  end
  
  it "game over when there is a tie" do
    mark((0...@board.size**2).to_a, "i")
    @rules.should be_game_over
  end
  
  
  context "winner" do
    context "wins horizontally" do
      it "is the player when player marks all the first row" do
        mark([0, 1, 2], @player)
        @rules.winner.should == @player
      end
      
      it "is the player when player marks all the middle row" do
        mark([3, 4, 5], @player)
        @rules.winner.should == @player
      end
      
      it "is the player when player marks all the last row" do
        mark([6, 7, 8], @player)
        @rules.winner.should == @player
      end
      
      it "is the opponent when opponent marks all the middle row" do
        mark([3, 4, 5], @opponent)
        @rules.winner.should == @opponent        
      end
      
      it "is nil when player marks two horizontal squares" do
        mark([0, 1], @player)
        @rules.winner.should be_nil
      end
      
      it "is nil when player marks two squares and opponent marks one" do
        mark([0, 2], @player)
        mark([1], @opponent)
        @rules.winner.should be_nil
      end
    end
    
    context "wins vertically" do
      it "is the opponent when opponent marks all the first column" do
        mark([0, 3, 6], @opponent)
        @rules.winner.should == @opponent
      end
      
      it "is the opponent when opponent marks all the middle column" do
        mark([1, 4, 7], @opponent)
        @rules.winner.should == @opponent
      end
      
      it "is the opponent when opponent marks the last column" do
        mark([2, 5, 8], @opponent)
        @rules.winner.should == @opponent
      end
      
      it "is the player when player marks all the middle column" do
        mark([1, 4, 7], @player)
        @rules.winner.should == @player
      end
      
      it "is nil when player marks two vertical squares" do
        mark([2, 5], @player)
        @rules.winner.should be_nil
      end
      
      it "is nil when player marks two squares and opponent marks one" do
        mark([0, 3], @player)
        mark([6], @opponent)
        @rules.winner.should be_nil
      end
    end
    
    context "wins diagonally" do
      it "is player when player marks all the top left to right diagonal squares" do
        mark([0, 4, 8], @player)
        @rules.winner.should == @player
      end
        
      it "is opponent when opponent marks all the top right to left diagonal squares" do
        mark([2, 4, 6], @opponent)
        @rules.winner.should == @opponent
      end
        
      it "is nil when player marks only two top left to right diagonal squares" do
        mark([0, 4], @player)
        @rules.winner.should be_nil
      end
        
      it "is nil when player marks only two top right to left diagonal squares" do
        mark([2, 4], @player)
        @rules.winner.should be_nil
      end
        
      it "is nil when player marks two squares and opponent marks one" do
        mark([0, 4], @player)
        mark([8], @opponent)
        @rules.winner.should be_nil
      end
    end
    
    it "is nil when there is a tied" do
      (@board.size**2).times {|i| @board.mark(i, "i")}
      @rules.winner.should be_nil
    end
  end
  
  def mark(squares, value)
    squares.each {|i| @board.mark(i, value)}
  end
end