require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/player'
require 'tic_tac_toe/board'
require 'tic_tac_toe/values'
require 'mocks/strategy/dynamic'

describe TicTacToe::Player do
  before(:each) do
    @move = 4
    @value = TicTacToe::VALUES[0]
    @name = "blu"
    @strategy = MockDynamicStrategy.new([@move])
    @player = TicTacToe::Player.new(@name, @value, @strategy)
  end

  it "gets name" do
    @player.name.should == @name
  end

  it "gets player value" do
    @player.value.should == @value
  end

  it "gets strategy" do
    @player.strategy.should == @strategy
  end

  it "makes move" do
    board = TicTacToe::Board.new
    @player.move(board)
    board.available_moves.should_not include(@move)
  end
end
