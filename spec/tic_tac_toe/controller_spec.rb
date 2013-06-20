require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/controller'


describe TicTacToe::Controller do
  before(:each) do
    @ui = mock.as_null_object
    @controller = TicTacToe::Controller.new(@ui, mock.as_null_object)
  end

  describe "play game" do
    # before(:each) do
    #   @strategy_mock.add_move(1)
    # end

    it "displays welcome message when it starts a game" do
      @ui.should_receive(:display_welcome_message)
      @controller.start
    end

    # it "display board" do
    #   @ui.should_receive(:display_board)
    #   @controller.start
    # end
    #
    # it "mark the board with user input" do
    #   @controller.start
    #   @board.unique_marked_values.should include("X")
    # end
  end
  #
  # describe "end game" do
  #   before(:each) do
  #     @strategy_mock.add_move(1)
  #   end
  #
  #   it "displays the board when the game is over" do
  #     @ui.should_receive(:display_board).at_least(2)
  #     @controller.start
  #   end
  #
  #   it "notifies user when player wins" do
  #     @rules.should_receive(:game_over?).and_return(true)
  #     @rules.should_receive(:winner).and_return(@player.value)
  #     @ui.should_receive(:display_winner).with("Todd")
  #     @controller.start
  #   end
  #
  #   it "notifies user when it's a tied game" do
  #     @rules.should_receive(:game_over?).and_return(true)
  #     @rules.should_receive(:winner).and_return(nil)
  #     @ui.should_receive(:display_tied_game)
  #     @controller.start
  #   end
  # end
  #
  # describe "when there are two players" do
  #   before(:each) do
  #     @strategy_mock2 = MockStrategy.new
  #     @player2 = TicTacToe::Player.new(nil, nil, @strategy_mock2)
  #     @game.player2 = @player2
  #   end
  #
  #   it "changes to player 2 after player 1 moves" do
  #     @strategy_mock.add_move(1)
  #     @strategy_mock2.add_move(3)
  #     @rules.should_receive(:game_over?).and_return(false, true)
  #     @controller.start
  #
  #     @strategy_mock.moves.should be_empty
  #     @strategy_mock2.moves.should be_empty
  #   end
  #
  #   it "asks for user move again if user marks a move that is not available" do
  #     marked_move = 1
  #     @strategy_mock.add_move(marked_move)
  #     @strategy_mock.add_move(2)
  #     @board.mark(marked_move, @player)
  #     @rules.should_receive(:game_over?).and_return(true)
  #     @controller.start
  #
  #     @strategy_mock.moves.should be_empty
  #   end
  #
  # end
end
