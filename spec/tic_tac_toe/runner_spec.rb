require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/runner'

require 'mocks/game_factory'
require 'mocks/game'
require 'mocks/ui/console'
require 'mocks/player'

describe TicTacToe::Runner do
  attr_reader :runner, :game, :ui, :game_factory

  before(:each) do
    @game = MockGame.factory
    @game_factory = MockGameFactory.factory create: game
    @ui = MockConsole.factory
    @runner = TicTacToe::Runner.new(@ui, @game_factory)
  end

  it "displays a welcome message" do
    runner.start
    ui.was told_to(:display_welcome_message)
  end

  describe "create game state" do
    it "asks user for a game type" do
      runner.start
      @ui.was asked_for(:game_type)
    end

    it "asks game state factory to create a game with input game type" do
      game_type = 4
      ui.will_have_game_type 4
      runner.start
      @game_factory.was told_to(:create).with(game_type)
    end

    it "asks ui for game type again if the input is incorrect" do
      game_factory.will_create ArgumentError.new, game
      runner.start
      ui.was asked_for(:game_type).times(2)
    end
  end

  describe "play game" do
    attr_reader :player

    before(:each) do
      @player = MockPlayer.new
      game.will_over? false, true
      game.will_have_current_player @player
    end

    it "displays the board" do
      runner.start
      ui.was told_to(:display_board)
    end

    it "tells ui to display player turn" do
      runner.start
      ui.was told_to(:display_player_turn).with(player)
    end

    it "tells player to move again if there is an error" do
      game.will_make_player_move TicTacToe::MoveNotAvailableError.new, nil
      runner.start
      game.was told_to(:make_player_move).times(2)
    end
  end

  describe "end game" do
    it "display a board at the end of the game" do
      runner.start
      ui.was told_to(:display_board)
    end

    it "asks ui to display a winner if there is a winner" do
      winner = "Winner"
      game.will_have_winner winner
      runner.start
      ui.was told_to(:display_winner).with(winner)
    end

    it "asks ui to display a draw" do
      runner.start
      ui.was told_to(:display_tied_game)
    end
  end
end
