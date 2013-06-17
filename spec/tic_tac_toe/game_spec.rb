require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/game'
require 'tic_tac_toe/board'
require 'tic_tac_toe/strategy/mock'
require 'tic_tac_toe/player'

describe TicTacToe::Game do
  before(:each) do
    @board = TicTacToe::Board.new
    @ui = mock.as_null_object
    @rules = mock.as_null_object

    @game = TicTacToe::Game.new(@board, @ui, @rules)

    @strategy_mock = MockStrategy.new
    @player = TicTacToe::Player.new("Todd", "X", @strategy_mock)

    @game.player2 = @game.player1 = @player
  end

  describe "play game" do
    before(:each) do
      @strategy_mock.add_move(1)
    end

    it "displays welcome message when it starts a game" do
      @ui.should_receive(:display_welcome_message)
      @game.start
    end

    it "display board" do
      @ui.should_receive(:display_board)
      @game.start
    end

    it "mark the board with user input" do
      @game.start
      @board.unique_marked_values.should include("X")
    end
  end

  describe "end game" do
    before(:each) do
      @strategy_mock.add_move(1)
    end

    it "displays the board when the game is over" do
      @ui.should_receive(:display_board).at_least(2)
      @game.start
    end

    it "notifies user when player wins" do
      @rules.should_receive(:game_over?).and_return(true)
      @rules.should_receive(:winner).and_return(@player.value)
      @ui.should_receive(:display_winner).with("Todd")
      @game.start
    end

    it "notifies user when it's a tied game" do
      @rules.should_receive(:game_over?).and_return(true)
      @rules.should_receive(:winner).and_return(nil)
      @ui.should_receive(:display_tied_game)
      @game.start
    end
  end

  describe "when there are two players" do
    before(:each) do
      @strategy_mock2 = MockStrategy.new
      @player2 = TicTacToe::Player.new(nil, nil, @strategy_mock2)
      @game.player2 = @player2
    end

    it "changes to player 2 after player 1 moves" do
      @strategy_mock.add_move(1)
      @strategy_mock2.add_move(3)
      @rules.should_receive(:game_over?).and_return(false, true)
      @game.start

      @strategy_mock.moves.should be_empty
      @strategy_mock2.moves.should be_empty
    end

    it "asks for user move again if user marks a move that is not available" do
      marked_move = 1
      @strategy_mock.add_move(marked_move)
      @strategy_mock.add_move(2)
      @board.mark(marked_move, @player)
      @rules.should_receive(:game_over?).and_return(true)
      @game.start

      @strategy_mock.moves.should be_empty
    end

  end
end
