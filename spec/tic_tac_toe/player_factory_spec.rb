require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/player_factory'
require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/strategy/console_user'
require 'tic_tac_toe/values'

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
    it "returns a computer player with given value" do
      computer_value = "Danny"
      player = @factory.computer(computer_value)
      player.value.should == computer_value
    end

    it "checks default strategy" do
      @factory.computer.strategy.should be_kind_of(TicTacToe::Strategy::Minimax)
    end

    it "checks default name" do
      @factory.computer.name.should == "Computer"
    end

    it "checks default value" do
      @factory.computer.value.should == "O"
    end
  end

end
