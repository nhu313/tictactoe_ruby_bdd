require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/values'

describe TicTacToe::Strategy::Minimax, :slow_test => true do

  before(:each) do
    @board = TicTacToe::Board.new(3)
    @computer_value = TicTacToe::VALUES[1]
    @opponent_value = TicTacToe::Values.opponent(@computer_value)
    @strategy = TicTacToe::Strategy::Minimax.new(@computer_value)
  end

  context "move" do
    context "when there is only one position left" do
      it "returns move when it's a winning move" do
        mark((1...@board.size**2), @computer_value)
        @strategy.move(@board).should == 0
      end

      it "returns the move when it's a tied" do
        mark([0, 2, 5, 6], @computer_value)
        mark([1, 3, 4, 8], @opponent_value)
        @strategy.move(@board).should == 7
      end

      it "returns the move when opponent wins" do
        mark((0...@board.size**2 - 1).to_a, @opponent_value)
        @strategy.move(@board).should == 8
      end
    end

    context "when there are two positions left" do
      it "returns losing scores when the two moves are losing moves" do
        mark((2...@board.size**2).to_a, @opponent_value)
        @strategy.move(@board).should == 0
      end

      it "returns the first win move when the two moves are winning moves" do
        mark((2...@board.size**2).to_a, @computer_value)
        @strategy.move(@board).should == 0
      end

      it "returns the first tie move when the two moves are tie moves" do
        mark([0, 2, 7], @computer_value)
        mark([1, 4, 6, 8], @opponent_value)
        @strategy.move(@board).should == 3
      end

      it "returns win move when there are winning and losing moves" do
        mark([0, 1, 3, 7], @computer_value)
        mark([2, 4, 5], @opponent_value)
        @strategy.move(@board).should == 6
      end

      it "returns winning move when there are winning and tie moves" do
        mark([0, 2, 3, 4], @computer_value)
        mark([1, 5, 8], @opponent_value)
        @strategy.move(@board).should == 6
      end

      it "returns tied move when there are losing and tie moves" do
        mark([2, 3, 4], @computer_value)
        mark([0, 5, 6, 7], @opponent_value)
        @strategy.move(@board).should == 8
      end

      context "winning move appear later in the board" do
        it "returns win move when winning move is later than losing move" do
          mark([1, 2, 5, 7], @computer_value)
          mark([0, 3, 4], @opponent_value)
          @strategy.move(@board).should == 8
        end

        it "returns winning move when winning move is later than tie move" do
          mark([0, 2, 4, 5], @computer_value)
          mark([1, 3, 6], @opponent_value)
          @strategy.move(@board).should == 8
        end

        it "returns tied move when there are losing and tie moves" do
          mark([2, 3, 4], @computer_value)
          mark([0, 5, 6, 7], @opponent_value)
          @strategy.move(@board).should == 8
        end
      end
    end

    context "when there are three moves left" do
      it "chooses the winning move when there is one available" do
        mark([1, 4], @computer_value)
        mark([0, 3, 2, 5], @opponent_value)
        @strategy.move(@board).should == 7
      end

      it "chooses a tie move when there are only losing and tie moves" do
        mark([1, 4], @computer_value)
        mark([0, 2, 5, 7], @opponent_value)
        @strategy.move(@board).should == 8
      end
    end

    context "when there are 4 moves left" do
      it "chooses a winning move when one is available" do
        mark([0, 4], @computer_value)
        mark([1, 2, 6], @opponent_value)
        @strategy.move(@board).should == 8
      end

      it "chooses a move that would create 2 winning moves" do
        mark([0, 6], @computer_value)
        mark([1, 3, 5], @opponent_value)
        @strategy.move(@board).should == 4
      end
    end
  end

  it "chooses the winning move when available" do
    mark([1, 4], @computer_value)
    mark([0], @opponent_value)
    @strategy.move(@board).should == 7
  end

  it "chooses the winning move when available" do
    mark([0, 4], @computer_value)
    mark([1, 2], @opponent_value)
    @strategy.move(@board).should == 8
  end

  it "chooses a blocking move when there is no winning move" do
    mark([2], @computer_value)
    mark([0, 4], @opponent_value)
    @strategy.move(@board).should == 8
  end

  it "chooses a blocking move when there is no winning move" do
    mark([2], @computer_value)
    mark([1, 4], @opponent_value)
    @strategy.move(@board).should == 7
  end

  it "chooses the middle square when computer is the second player" do
    mark([0], @opponent_value)
    @strategy.move(@board).should == 4
  end

  it "chooses the first corner of the board when the middle square is taken as a second player" do
    mark([4], @opponent_value)
    @strategy.move(@board).should == 0
  end

  it "chooses the middle square on the first move" do
    @strategy.move(@board).should == 4
  end

  def move_node(move, score)
    TicTacToe::Move.new(move, score)
  end

  def mark(squares, value)
    squares.each {|i| @board.mark(i, value)}
  end
end
