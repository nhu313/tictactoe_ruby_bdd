require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/game'

require 'mocks/game_state_factory'
require 'mocks/game_state'
require 'mocks/ui/console'
require 'mocks/player'

describe TicTacToe::Game do
  attr_reader :game, :ui, :game_state, :game_state_factory

  before(:each) do
    @game_state = MockGameState.factory
    @game_state_factory = MockGameStateFactory.factory create: game_state
    @ui = MockConsole.factory
    @game = TicTacToe::Game.new(@ui, @game_state_factory)
  end

  it "displays a welcome message" do
    game.start
    ui.was told_to(:display_welcome_message)
  end

  describe "create game state" do
    it "asks user for a game type" do
      game.start
      @ui.was asked_for(:game_type)
    end

    it "asks game state factory to create a game with input game type" do
      game_type = 4
      ui.will_have_game_type 4
      game.start
      @game_state_factory.was told_to(:create).with(game_type)
    end

    it "asks ui for game type again if the input is incorrect" do
      game_state_factory.will_create ArgumentError.new, game_state
      game.start
      ui.was asked_for(:game_type).times(2)
    end
  end

  describe "play game" do
    attr_reader :player

    before(:each) do
      @player = MockPlayer.new
      game_state.will_game_over? false, true
      game_state.will_have_current_player @player
    end

    it "displays the board" do
      game.start
      ui.was told_to(:display_board)
    end

    it "tells ui to display player turn" do
      game.start
      ui.was told_to(:display_player_turn).with(player)
    end

    it "told player to move" do
      game.start
      player.was told_to(:move)
    end

    it "tells player to move again if there is an error" do
      player.will_move TicTacToe::MoveNotAvailableError.new, nil
      game.start
      player.was told_to(:move).times(2)
    end

    it "changes the player after a player move" do
      game.start
      game_state.was told_to(:change_player)
    end

  end

  describe "end game" do
    it "display a board at the end of the game" do
      game.start
      ui.was told_to(:display_board)
    end

    it "asks ui to display a winner if there is a winner" do
      winner = "Winner"
      game_state.will_have_winner winner
      game.start
      ui.was told_to(:display_winner).with(winner)
    end

    it "asks ui to display a draw" do
      game.start
      ui.was told_to(:display_tied_game)
    end
  end
end
