require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/game'
require 'tic_tac_toe/board'
require 'tic_tac_toe/player'
require 'mocks/strategy/dynamic'

describe TicTacToe::Game do
  before(:each) do
    @board = TicTacToe::Board.new

    @todd_strategy = MockDynamicStrategy.new
    @todd = TicTacToe::Player.new("Todd", "X", @todd_strategy)

    @john_strategy = MockDynamicStrategy.new
    @john = TicTacToe::Player.new("John", "O", @john_strategy)

    @game = TicTacToe::Game.new(@board, @todd, @john)
  end

  context "marking board" do
    it "mark the board with user input" do
      @todd_strategy.add_move(1)
      @game.make_move
      @board.unique_marked_values.should include(@todd.value)
    end

    it "does not mark the board if user doesn't return an input" do
      @todd_strategy.add_move(nil)
      @game.make_move
      @board.unique_marked_values.should_not include(@todd.value)
    end
  end

  describe "return winner player based on the value return from rules" do
    it "is Todd when value is X" do
      mark_board([0, 1, 2], @todd.value)
      @game.winner.should == @todd
    end

    it "is John when it is O" do
      mark_board([0, 1, 2], @john.value)
      @game.winner.should == @john
    end

    it "is nil when no one wins" do
      @game.winner.should be_nil
    end
  end

  describe "changes player" do
    it "doesn't change player if player 1 doesn't return a move" do
      @game.current_player.should == @todd
      @todd_strategy.add_move(nil)

      @game.make_move
      @game.current_player.should == @todd
    end

    it "changes to player 2 after player 1 moves" do
      @game.current_player.should == @todd
      @todd_strategy.add_move(1)

      @game.make_move
      @game.current_player.should == @john
    end
  end

  describe "game over" do
    it "is over when there is a winner" do
      mark_board([0, 1, 2], @john.value)
      @game.should be_over
    end

    it "is over when there is a tied" do
      mark_board((0...9).to_a, "i")
      @game.should be_over
    end

    it "is not over when there is no mark on the board" do
      @game.should_not be_over
    end

    it "is not over when there is no winner or a tied" do
      mark_board([1, 2], @todd.value)
      @game.should_not be_over
    end
  end

  def mark_board(moves, value)
    moves.each do |m|
      @board.mark(m, value)
    end
  end
end
