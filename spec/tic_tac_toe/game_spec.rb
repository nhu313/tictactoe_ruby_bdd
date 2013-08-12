require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/game'
require 'tic_tac_toe/player'
require 'tic_tac_toe/values'
require 'mocks/strategy/dynamic'

describe TicTacToe::Game do
  attr_reader :game, :player1, :player2, :board

  before(:each) do
    @board = TicTacToe::Board.new
    @player1_strategy = MockDynamicStrategy.new
    @player1 = TicTacToe::Player.new("player1", TicTacToe::VALUES[0], @player1_strategy)
    @player2 = TicTacToe::Player.new("player1", TicTacToe::VALUES[1], nil)
    @game = TicTacToe::Game.new([@player1, @player2], @board)
  end


  it "can read board" do
    game.board.should == board
  end

  describe "game over" do
    it "is false when there is no mark" do
      game.should_not be_over
    end

    it "should be over when there is a winner" do
      mark_winning_board(player1.value)
      game.should be_over
    end
  end

  describe "winner" do
    it "has no winner when there is no mark" do
      game.winner.should be_nil
    end

    it "is player 1" do
      mark_winning_board(player1.value)
      game.winner.should == player1
    end

    it "is player 2" do
      mark_winning_board(player2.value)
      game.winner.should == player2
    end
  end

  context "make player move" do
    it "mark the board with player move when caller doesn't pass in a move" do
      @player1_strategy.add_move(1)
      @game.make_player_move
      @board.unique_marked_values.should include(@player1.value)
    end

    it "does not mark the board if user doesn't return an input and caller didn't pass in a move" do
      @player1_strategy.add_move(nil)
      @game.make_player_move
      @board.unique_marked_values.should_not include(@player1.value)
    end

    it "marks the board with the move passed in" do
      @player1_strategy.add_move(1)
      move = 2
      @game.make_player_move(move)
      @board.available_moves.should_not include(move)
    end

    it "marks the board with player move when move passed in is nil" do
      @player1_strategy.add_move(1)
      @game.make_player_move(nil)
      @board.available_moves.should_not include(1)
    end

    it "marks the board with current player value when the move passed in" do
      move = 2
      @game.make_player_move(move)
      @board.unique_marked_values.should include(@player1.value)
    end
  end

  describe "changes player" do
    it "doesn't change player if player 1 doesn't return a move" do
      @game.current_player.should == @player1
      @game.make_player_move
      @game.current_player.should == @player1
    end

    it "changes to player 2 after player 1 moves" do
      @game.current_player.should == @player1
      @game.make_player_move(1)
      @game.current_player.should == @player2
    end
  end


  def mark_winning_board(value)
    [0, 4, 8].each do |move|
      game.board.mark(move, value)
    end
  end
end
