require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/player'
require 'mocks/strategy/dynamic'

describe TicTacToe::Player do

  it "gets name" do
    name = "bruce"
    player = TicTacToe::Player.new(name, nil, nil)
    player.name.should == name
  end

  it "gets player value" do
    value = "X"
    player = TicTacToe::Player.new(nil, value, nil)
    player.value.should == value
  end

  it "gets player's move" do
    move = 4
    strategy = MockDynamicStrategy.new([4])
    player = TicTacToe::Player.new(nil, nil, strategy)
    player.move.should == move
  end

  it "gets strategy" do
    strategy = MockDynamicStrategy.new([4])
    player = TicTacToe::Player.new(nil, nil, strategy)
    player.strategy.should == strategy

  end
end
