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

  describe "get player based on value" do
    it "returns player 1 given player 1 value" do
      game_state.player(player1.value).should == player1
    end

    it "returns player 2 given player 2 value" do
      game_state.player(player2.value).should == player2
    end

  end
end
