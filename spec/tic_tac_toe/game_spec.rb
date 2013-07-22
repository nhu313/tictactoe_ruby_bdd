require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/game'
require 'tic_tac_toe/board'
require 'tic_tac_toe/player'
require 'mocks/strategy/dynamic'

describe TicTacToe::Game do
  before(:each) do
    @board = TicTacToe::Board.new

    @player1_strategy = MockDynamicStrategy.new
    @player1 = TicTacToe::Player.new("Todd", "X", @player1_strategy)

    @player2_strategy = MockDynamicStrategy.new
    @player2 = TicTacToe::Player.new("John", "O", @player2_strategy)

    @game = TicTacToe::Game.new(@board, @player1, @player2)
  end

  context "marking board" do
    it "mark the board with user input" do
      @player1_strategy.add_move(1)
      @game.make_move
      @board.unique_marked_values.should include(@player1.value)
    end

    it "does not mark the board if user doesn't return an input" do
      @player1_strategy.add_move(nil)
      @game.make_move
      @board.unique_marked_values.should_not include(@player1.value)
    end
  end

  describe "return winner player based on the value return from rules" do
    it "is Todd when value is X" do
      mark_board([0, 1, 2], @player1.value)
      @game.winner.should == @player1
    end

    it "is John when it is O" do
      mark_board([0, 1, 2], @player2.value)
      @game.winner.should == @player2
    end

    it "is nil when no one wins" do
      @game.winner.should be_nil
    end
  end

  describe "changes player" do
    it "doesn't change player if player 1 doesn't return a move" do
      @game.current_player.should == @player1
      @player1_strategy.add_move(nil)

      @game.make_move
      @game.current_player.should == @player1
    end

    it "changes to player 2 after player 1 moves" do
      @game.current_player.should == @player1
      @player1_strategy.add_move(1)

      @game.make_move
      @game.current_player.should == @player2
    end
  end

  describe "game over" do
    it "is over when there is a winner" do
      mark_board([0, 1, 2], @player2.value)
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
      mark_board([1, 2], @player1.value)
      @game.should_not be_over
    end
  end

  def mark_board(moves, value)
    moves.each do |m|
      @board.mark(m, value)
    end
  end
end
