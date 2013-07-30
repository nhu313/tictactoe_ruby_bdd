require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/game_state'
require 'tic_tac_toe/player'
require 'tic_tac_toe/values'

describe TicTacToe::GameState do
  attr_reader :game_state, :player1, :player2, :board

  before(:each) do
    @board = TicTacToe::Board.new
    @player1 = TicTacToe::Player.new("player1", TicTacToe::VALUES[0], nil)
    @player2 = TicTacToe::Player.new("player1", TicTacToe::VALUES[1], nil)
    @game_state = TicTacToe::GameState.new([@player1, @player2], @board)
  end


  it "can read board" do
    game_state.board.should == board
  end

  describe "current player" do
    it "starts with player 1 as the current player" do
      game_state.current_player.should == player1
    end

    it "changes current player to player 2" do
      game_state.current_player.should == player1
      game_state.change_player
      game_state.current_player.should == player2
    end

    it "changes current player to player 1 after two calls on change player" do
      game_state.current_player.should == player1
      game_state.change_player
      game_state.change_player
      game_state.current_player.should == player1
    end
  end

  describe "game over" do
    it "is false when there is no mark" do
      game_state.should_not be_game_over
    end

    it "should be over when there is a winner" do
      mark_winning_board(player1.value)
      game_state.should be_game_over
    end
  end

  describe "winner" do
    it "has no winner when there is no mark" do
      game_state.winner.should be_nil
    end

    it "is player 1" do
      mark_winning_board(player1.value)
      game_state.winner.should == player1
    end

    it "is player 2" do
      mark_winning_board(player2.value)
      game_state.winner.should == player2
    end
  end

  def mark_winning_board(value)
    [0, 4, 8].each do |move|
      game_state.board.mark(move, value)
    end
  end
end
