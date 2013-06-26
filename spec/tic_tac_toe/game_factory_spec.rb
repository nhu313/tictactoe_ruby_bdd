require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/game_factory'
require 'tic_tac_toe/player_factory'
require 'mocks/player_factory'

describe TicTacToe::GameFactory do

  before(:each) do
    @board = "board"
    @player_factory = MockPlayerFactory.new
    @game_factory = TicTacToe::GameFactory.new(@player_factory)
  end

  it "ensures MockPlayerFactory has the same interface as PlayerFactory" do
    MockPlayerFactory.should be_substitutable_for(TicTacToe::PlayerFactory)
  end

  it "returns 4 types of games" do
    @game_factory.types.size.should == 4
  end

  it "sets the board in the game" do
    game = @game_factory.create(1, @board)
    game.board.should == @board
  end

  it "returns human vs computer game" do
    human = "human"
    computer = "computer"
    @player_factory.will_have_human human
    @player_factory.will_have_computer computer

    game = @game_factory.create(1, @board)
    game.current_player.should == human

    @player_factory.was asked_for :computer
    @player_factory.was asked_for :human
  end

  it "returns computer vs human game" do
    human = "human"
    computer = "computer"
    @player_factory.will_have_human human
    @player_factory.will_have_computer computer

    game = @game_factory.create(2, @board)
    game.current_player.should == computer

    @player_factory.was asked_for :computer
    @player_factory.was asked_for :human
  end

  it "returns user vs user game" do
    human1 = "mary"
    human2 = "alice"
    @player_factory.will_have_human human1, human2

    game = @game_factory.create(3, @board)
    game.current_player.should == human1

    @player_factory.was asked_for(:human).times(2)
  end

  it "returns computer vs computer game" do
    computer1 = "computer1"
    computer2 = "computer2"
    @player_factory.will_have_computer computer2, computer1

    game = @game_factory.create(4, @board)
    game.current_player.should == computer2

    @player_factory.was asked_for(:computer).times(2)
  end

  it "raises an error when the game type doesn't exist" do
    lambda{@game_factory.create(5, @board)}.should raise_error(ArgumentError)

  end
end
