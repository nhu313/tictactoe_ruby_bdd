require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/game_factory'

describe TicTacToe::GameFactory do

  it "returns 3 types of games" do
    TicTacToe::GameFactory.new.types.size.should == 3
  end

  it "returns user vs user game" do

  end

  it "returns user vs computer game" do

  end

  it "returns computer vs user game" do

  end

end
