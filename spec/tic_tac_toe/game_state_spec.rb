require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/board'
require 'tic_tac_toe/game_state'
require 'mocks/strategy/dynamic'

describe TicTacToe::GameState do
  it "can read board" do
    board = TicTacToe::Board.new
    TicTacToe::GameState.new(board, [1,2]).board.should == board
  end

  describe "current player" do
    attr_reader :game_state, :player1, :player2

    before(:each) do
      @player1 = "player1"
      @player2 = "player2"
      @game_state = TicTacToe::GameState.new(nil, [@player1, @player2])
    end

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
end
