require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/board'

describe TicTacToe::Board do
  before(:each) do
    @player = "X"
    @size = 3
    @board = TicTacToe::Board.new(@size)
  end

  it "clears all the markings for the board" do
    @board.mark(0, @player)
    @board.reset
    @board.squares.should_not include @player
  end

  context "marking the board" do
    it "marks the board" do
      @board.mark(0, @player)
      @board.available_moves.should_not include 0
    end

    context "raises an exception" do
      it "when move is less than the first square" do
        lambda {@board.mark(-1, @player)}.should raise_error TicTacToe::MoveNotAvailableError
      end

      it "when move is higher than the last square" do
        lambda {@board.mark(9, @player)}.should raise_error TicTacToe::MoveNotAvailableError
      end

      it "when move is already mark" do
        @board.mark(0, @player)
        lambda {@board.mark(0, @player)}.should raise_error TicTacToe::MoveNotAvailableError
      end

    end
  end

  context "number of moves made" do
    it "is 0 when there is no move" do
      @board.number_of_moves.should == 0
    end

    it "is 1 after user makes a move" do
      @board.mark(0, @player)
      @board.number_of_moves.should == 1
    end

    it "is 9 when user marks all the squares" do
      mark_all_squares
      @board.number_of_moves.should == @size**2
    end
  end

  it "clears the value" do
    @board.mark(0, @player)
    @board.clear(0)
    @board.available_moves.should include 0
  end

  context "filled?" do
    it "is true when all the squares are marked" do
      mark_all_squares
      @board.should be_filled
    end

    it "is false when the board is empty" do
      @board.should_not be_filled
    end

    it "is false when all but one squares are marked" do
      mark_all_squares
      @board.clear(0)
      @board.should_not be_filled
    end
  end

  context "empty?" do


  end

	it "board @size is the @size set" do
		@board.size.should == @size
	end

  describe "rows" do
    it "number of board rows is the same as the board @size" do
      rows = @board.rows
      rows.size.should == @size
    end

    it "the first element in the rows is the first row" do
      @board.mark(0, @player)
      rows = @board.rows
      rows[0].should == [@player, nil, nil]
    end

    it "returns the rows with the middle element as the middle rows" do
      @board.mark(3, @player)
      rows = @board.rows
      rows[@size/2].should == [@player, nil, nil]
    end

    it "returns the rows with the last elements as the last rows" do
      @board.mark(6, @player)
      rows = @board.rows
      rows[@size - 1].should == [@player, nil, nil]
    end

    it "returns an empty row when the squares in the row is not mark" do
      rows = @board.rows
      rows[0].should == default_square_sets[0]
    end
  end

  describe "columns" do
    it "returns the columns of the boards" do
      cols = default_square_sets(3)
      @board.columns.should == cols
    end

    it "number of columns is the @size of the board" do
      @board.columns.size.should == @size
    end
  end

  describe "diagonals" do
    it "returns the diagonal squares" do
      squares = default_square_sets(2)
      @board.diagonals.should == squares
    end

    it "returns the diagonal squares with the marked value" do
      @board.mark(4, @player)
      squares = [[nil, @player, nil], [nil, @player, nil]]
      @board.diagonals.should == squares
    end
  end

  describe "available squares" do
    it "returns all squares when none is marked" do
      @board.available_moves.should == (0...@size**2).to_a
    end

    it "doesn't return the marked square" do
      move = 2
      @board.mark(move, @player)
      @board.available_moves.should_not include move
    end

    it "is empty when all the squares are marked" do
      mark_all_squares
      @board.available_moves.should == []
    end
  end

  describe "unique marks" do
    it "returns user marks when user marks the board" do
      @board.mark(4, @player)
      @board.unique_marked_values.should == [@player]
    end

    it "returns two marks when two user marks the board" do
      @board.mark(4, "X")
      @board.mark(0, "O")
      @board.unique_marked_values.should =~ ["X", "O"]
    end

    it "returns one mark even though user marks the board twice" do
      @board.mark(4, @player)
      @board.mark(0, @player)
      @board.unique_marked_values.should == [@player]
    end

  end

  describe "creating a copy of the board" do
    it "is marked on the copy when the original is marked" do
      @board.mark(4, "X")
      board_copy = @board.clone

      board_copy.available_moves.should_not include(4)
    end

    it "is unaffected by changes to the original" do
      @board.mark(4, "X")
      board_copy = @board.clone
      @board.mark(5, "O")

      board_copy.available_moves.should include(5)
    end

    it "marks the actual value" do
      @board.mark(4, "X")
      board_copy = @board.clone

      board_copy.unique_marked_values.should == ["X"]
    end
  end

  def mark_all_squares
    (0...@size**2).each {|position| @board.mark(position, @player)}
  end

  def default_square_sets(size = 1)
    Array.new(size, Array.new(3))
  end
end
