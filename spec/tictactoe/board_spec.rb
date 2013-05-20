require 'tictactoe/board'

describe TicTacToe::Board do
  attr_reader :board, :size, :player_value
  
  before(:each) do
    @player_value = "X"
    @size = 3
    @board = TicTacToe::Board.new(@size)
  end
  
  it "clears all the markings for the board on clear" do
    board.mark(0, @player_value)
    board.clear
    board.squares.include?(player_value).should be_false
  end
  
  it "is filled when all the squares are marked" do
    mark_all_squares
    board.should be_filled
  end
  
  def mark_all_squares
    (0...size**2).each {|position| board.mark(position, player_value)}
  end

	it "board size is the size set" do
		board.size.should == size
	end
  
  describe "rows" do
    it "number of board rows is the same as the board size" do
      rows = board.rows
      rows.size.should == size
    end
  
    it "the first element in the rows is the first row" do
      rows = board.rows
      rows[0].should == [0, 1, 2]
    end
  
    it "returns the rows with the middle element as the middle rows" do
      rows = board.rows
      rows[size/2].should == [3, 4, 5]
    end
    
    it "returns the rows with the last elements as the last rows" do
      rows = board.rows
      rows[size - 1].should == [6, 7, 8]
    end
  end
  
  describe "columns" do
    it "returns the columns of the boards" do
      cols = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
      board.columns.should == cols
    end
    
    it "number of columns is the size of the board" do
      board.columns.size.should == size
    end
  end
  
  describe "diagonals" do
    it "returns the diagonal squares" do
      squares = [[0, 4, 8], [2, 4, 6]]
      board.diagonals.should == squares
    end
    
    it "returns the diagonal squares with the marked value" do
      board.mark(4, player_value)
      squares = [[0, player_value, 8], [2, player_value, 6]]
      board.diagonals.should == squares
    end
  end
  
  describe "available squares" do
    it "returns all squares when none is marked" do
      board.available_squares.should == (0...size**2).to_a
    end
    
    it "doesn't return the marked square" do
      move = 2
      board.mark(move, player_value)
      board.available_squares.include?(move).should be_false
    end
    
    it "is empty when all the squares are marked" do
      mark_all_squares
      board.available_squares.should == []
    end
  end
end