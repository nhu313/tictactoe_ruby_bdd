require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/player'
require 'tic_tac_toe/game'
require 'tic_tac_toe/rules'
require 'tic_tac_toe/board'
require 'mocks/game_state_factory'
require 'mocks/ui/console'
require 'mocks/strategy/dynamic'
require 'mocks/rules'

describe TicTacToe::Game do
  before(:each) do
    @board = TicTacToe::Board.new
    @ui = MockConsole.factory
    @player1 = TicTacToe::Player.new("Player 1", "X", MockDynamicStrategy.new([]))
    @player2 = TicTacToe::Player.new("Player 2", "O", MockDynamicStrategy.new([]))

    @game_state = TicTacToe::GameState.new(@board, [@player1, @player2])
    @game_state_factory = MockGameStateFactory.factory create: @game_state

    @controller = TicTacToe::Game.new(@ui, @game_state_factory)
    @rules = MockRules.factory game_over?: true
    @controller.rules = @rules

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
      @game_state_factory.was told_to(:create)
    end

    it "asks ui for game type again if the input is incorrect" do
      @game_state_factory.will_create ArgumentError.new, @game_state
      @controller.start
      @ui.was asked_for(:game_type).times(2)
    end
  end

  describe "play game" do
    before(:each) do
      @rules.will_game_over? false, true
      # @player1.strategy.add_move(1)
    end

    it "display board" do
      @controller.start
      @ui.was told_to(:display_board)
    end

    it "displays whose turn it is" do
      @controller.start
      @ui.was told_to(:display_player_turn).with(@player1)
    end
  #
  #   it "tells game to make a move" do
  #     @game.will_over? false, true
  #     @controller.start
  #     @game.was told_to(:make_move)
  #   end
  #
  #   it "asks for game move until game is over" do
  #     @game.will_over? false, false, false, true
  #     @controller.start
  #     @game.was told_to(:make_move).times(3)
  #   end
  #
    # it "displays message when square is not available" do
    #   @controller.start
    #   @ui.was told_to(:display_square_not_available)
    # end
  end

  context "marking board" do
    it "mark the board with user input" do
      @controller.start
      @board.unique_marked_values.should include(@player1.value)
    end

    xit "does not mark the board if user doesn't return an input" do
      @player1_strategy.add_move(nil)
      @game.make_move
      @board.unique_marked_values.should_not include(@player1.value)
    end
  end


  describe "end game" do
    it "displays the board when the game is over" do
      @controller.start
      @ui.was told_to(:display_board)
    end

    it "notifies user when player wins" do
      @controller.start
      @ui.was told_to(:display_winner).with(@player1)
    end

    it "notifies user when it's a tied game" do

      @controller.start
      @ui.was told_to(:display_tied_game)
    end
  end
end
