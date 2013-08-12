require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/player_factory'
require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/strategy/console_user'
require 'tic_tac_toe/values'

describe TicTacToe::PlayerFactory do
  before(:each) do
    @factory = TicTacToe::PlayerFactory.new
    @value = TicTacToe::VALUES[0]
  end

  it "checks player types" do
    [:human, :computer] == @factory.types
  end

  context "human player" do
    before(:each) do
      @human = @factory.create(:human, @value)
    end

    it "strategy is console user" do
      @human.strategy.should be_kind_of(TicTacToe::Strategy::ConsoleUser)
    end

    it "checks name" do
      @human.name.should == "User"
    end

    it "checks value" do
      @human.value.should == @value
    end
  end

  context "computer player" do
    before(:each) do
      @computer = @factory.create(:computer, @value)
    end

    it "checks strategy" do
      @computer.strategy.should be_kind_of(TicTacToe::Strategy::Minimax)
    end

    it "checks name" do
      @computer.name.should == "Computer"
    end

    it "checks value" do
      @computer.value.should == @value
    end
  end
end
