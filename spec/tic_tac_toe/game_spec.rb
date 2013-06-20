require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/game'
require 'tic_tac_toe/board'
require 'tic_tac_toe/strategy/mock'
require 'tic_tac_toe/player'

describe TicTacToe::Game do
  before(:each) do
    @board = TicTacToe::Board.new
    @player1_strategy = MockStrategy.new
    @player1 = TicTacToe::Player.new("Todd", "X", @player1_strategy)

    @player2_strategy = MockStrategy.new
    @player2 = TicTacToe::Player.new("Tim", "O", @player2_strategy)

    @game = TicTacToe::Game.new(@board, @player1, @player2)
  end

  context "marking board" do
    it "mark the board with user input" do
      @player1_strategy.add_move(1)
      @game.move
      @board.unique_marked_values.should include(@player1.value)
    end

    it "does not mark the board if user doesn't return an input" do
      @player1_strategy.add_move(nil)
      @game.move
      @board.unique_marked_values.should_not include(@player1.value)
    end
  end

  describe "result message" do
    it "detects winner is player 1" do
      @game.result_msg(@player1.value).should match "Todd win!"
    end

    it "detects winner is player 2" do
      @game.result_msg(@player2.value).should match "Tim win!"
    end

    it "is tied when no winner is supplied" do
      @game.result_msg(nil).should match "It's a tie!"
    end
  end

  describe "changes player" do
    it "doesn't change player if player 1 doesn't return a move" do
      @game.current_player.should == @player1
      @player1_strategy.add_move(nil)

      @game.move
      @game.current_player.should == @player1
    end

    it "changes to player 2 after player 1 moves" do
      @game.current_player.should == @player1
      @player1_strategy.add_move(1)

      @game.move
      @game.current_player.should == @player2
    end
  end
end
