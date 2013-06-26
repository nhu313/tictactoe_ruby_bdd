require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/controller'
require 'tic_tac_toe/player'
require 'tic_tac_toe/game'
require 'tic_tac_toe/rules'
require 'tic_tac_toe/board'
require 'mocks/game'
require 'mocks/game_factory'
require 'mocks/ui/console'
require 'mocks/strategy/dynamic'
require 'mocks/rules'

describe TicTacToe::Controller do
  before(:each) do
    @rules = MockRules.new("board")
    @ui = MockConsole.factory
    @todd = TicTacToe::Player.new("Todd", "X", MockDynamicStrategy.new([1,2,3]))
    @game = MockGame.factory current_player: @todd, player: @todd
    @game_factory = MockGameFactory.factory create: @game
    @controller = TicTacToe::Controller.new(@ui, @game_factory)
    @controller.rules = @rules
  end

  context "ensure mock class has the same interface" do
    it "checks MockGame" do
      MockGame.should be_substitutable_for(TicTacToe::Game)
    end

    it "checks console" do
      MockConsole.should be_substitutable_for(TicTacToe::Console)
    end

    it "checks game factory" do
      MockGameFactory.should be_substitutable_for(TicTacToe::GameFactory)
    end

    it "checks rules" do
      MockRules.should be_substitutable_for(TicTacToe::Rules)
    end
  end

  describe "starts game" do
    it "displays welcome message" do
      @controller.start
      @ui.was told_to(:display_welcome_message)
    end

    it "asked ui to get game type" do
      @controller.start
      @ui.was asked_for(:game_type)
    end

    it "creates a game based on user input" do
      @controller.start
      @game_factory.was told_to(:create)
    end
  end

  describe "play game" do
    before(:each) do
      @rules.will_game_over? false, true
    end

    it "display board" do
      @controller.start
      @ui.was told_to(:display_board)
    end

    it "displays whose turn it is" do
      @controller.start
      @ui.was told_to(:display_player_turn).with(@todd)
    end

    it "tells game to make a move" do
      @rules.will_game_over? false, true
      @controller.start
      @game.was told_to(:make_move)
    end

    it "asks for game move until game is over" do
      @rules.will_game_over? false, false, false, true
      @controller.start
      @game.was told_to(:make_move).times(3)
    end

    it "displays message when square is not available" do
      @game.will_make_move TicTacToe::MoveNotAvailableError.new
      @controller.start
      @ui.was told_to(:display_square_not_available)
    end
  end

  describe "end game" do
    it "displays the board when the game is over" do
      @controller.start
      @ui.was told_to(:display_board)
    end

    it "notifies user when player wins" do
      @controller.start
      @ui.was told_to(:display_winner).with(@todd)
    end

    it "notifies user when it's a tied game" do
      @game.will_have_player nil
      @controller.start
      @ui.was told_to(:display_tied_game)
    end
  end
end
