require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/player_factory'
require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/strategy/console_user'

describe TicTacToe::PlayerFactory do

  before(:each) do
    @factory = TicTacToe::PlayerFactory.new
  end

  context "console player" do
    it "returns a console player with passed in values" do
      name = "Billy"
      value = "bill"
      player = @factory.human(name, value)
      player.name.should == name
      player.value.should == value
    end

    it "strategy is console user" do
      @factory.human.strategy.should be_kind_of(TicTacToe::Strategy::ConsoleUser)
    end

    it "checks default name" do
      @factory.human.name.should == "User"
    end

    it "checks default value" do
      @factory.human.value.should == "X"
    end
  end

  context "computer player" do
    before(:each) do
      @board = "fake board"
    end

    it "returns a computer player with given value" do
      computer_value = "Danny"
      opponent_value = "Bill"
      player = @factory.computer(@board, computer_value, opponent_value)
      player.value.should == computer_value
    end

    it "checks default strategy" do
      @factory.computer(@board).strategy.should be_kind_of(TicTacToe::Strategy::Minimax)
    end

    it "checks default name" do
      @factory.computer(@board).name.should == "Computer"
    end

    it "checks default value" do
      @factory.computer(@board).value.should == "O"
    end
  end

end
