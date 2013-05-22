require 'tictactoe/rules'
require 'tictactoe/board'

describe TicTacToe::Rules do
    
  before(:each) do
    @player_value = "X"
    @board = TicTacToe::Board.new(3)
    @win_determiner = TicTacToe::Rules.new(@board)
  end
  
  it "is false when player didn't mark any squares" do
    @win_determiner.win?(@player_value).should be_false
  end

  it "is false when player marks one square" do
    mark([0])
    @win_determiner.win?(@player_value).should be_false
  end
    
  context "wins horizontally" do
    it "is true when player marks all the first row" do
      mark([0, 1, 2])
      @win_determiner.win?(@player_value).should be_true
    end
    
    it "is true when player marks all the middle row" do
      mark([3, 4, 5])
      @win_determiner.win?(@player_value).should be_true
    end
    
    it "is true when player marks all the last row" do
      mark([6, 7, 8])
      @win_determiner.win?(@player_value).should be_true
    end
    
    it "is false when player marks two horizontal squares" do
      mark([0, 1])
      @win_determiner.win?(@player_value).should be_false
    end
    
    it "is false when player marks two squares and opponent marks one" do
      @board.mark(1, "O")
      mark([0, 2])
      @win_determiner.win?(@player_value).should be_false
    end
  end
  
  context "wins vertically" do
    it "is true when player marks all the first column" do
      mark([0, 3, 6])
      @win_determiner.win?(@player_value).should be_true
    end
    
    it "is true when player marks all the middle column" do
      mark([1, 4, 7])
      @win_determiner.win?(@player_value).should be_true
    end
    
    it "is true when player marks all the last column" do
      mark([2, 5, 8])
      @win_determiner.win?(@player_value).should be_true
    end
    
    it "is false when player marks only two vertical squares" do
      mark([2, 5])
      @win_determiner.win?(@player_value).should be_false
    end
    
    it "is false when player marks two squares and opponent marks one" do
      @board.mark(1, "O")
      mark([4, 7])
      @win_determiner.win?(@player_value).should be_false
    end
  end
  
  context "wins diagonally" do
    it "is true when player marks all the top left to right diagonal squares" do
      mark([0, 4, 8])
      @win_determiner.win?(@player_value).should be_true
    end
    
    it "is true when player marks all the top right to left diagonal squares" do
      mark([2, 4, 6])
      @win_determiner.win?(@player_value).should be_true
    end
    
    it "is false when player marks only two top left to right diagonal squares" do
      mark([0, 4])
      @win_determiner.win?(@player_value).should be_false
    end
    
    it "is false when player marks only two top right to left diagonal squares" do
      mark([2, 4])
      @win_determiner.win?(@player_value).should be_false
    end
    
    it "is false when player marks two squares and opponent marks one" do
      @board.mark(8, "O")
      mark([0, 4])
      @win_determiner.win?(@player_value).should be_false
    end
  end
  
  context "tied" do
    it "is false when the board is empty" do
      @win_determiner.tied?(@player_value).should be_false
    end
    
    it "is false when there is a winner" do
      mark([0, 1, 2])
      @win_determiner.tied?(@player_value).should be_false
    end
    
    it "is false when there is a winner and the board is filled" do
      mark((0...@board.size**2).to_a)
      @win_determiner.tied?(@player_value).should be_false
    end
    
    it "is false when there is no winner and the board is not filled" do
      mark([0])
      @win_determiner.tied?(@player_value).should be_false
    end
    
    it "is true when there is no winner and the board is filled" do
      (@board.size**2).times {|i| @board.mark(i, "i")}
      @win_determiner.tied?(@player_value).should be_true
    end
  end
  
  def mark(squares)
    squares.each {|i| @board.mark(i, @player_value)}
  end
end