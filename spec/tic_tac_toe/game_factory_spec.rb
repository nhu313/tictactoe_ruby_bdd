require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/game_factory'
require 'tic_tac_toe/player_factory_mock'

describe TicTacToe::GameFactory do

  before(:each) do
    @board = "board"
    @player_factory = PlayerFactoryMock.new
    @game_factory = TicTacToe::GameFactory.new(@player_factory)
  end

  it "returns 3 types of games" do
    @game_factory.types.size.should == 3
  end

  it "returns user vs computer game" do
    game = @game_factory.create(1, @board)
    game.current_player.should == "Human"
    game.board.should == @board
  end

  it "returns computer vs user game" do
    game = @game_factory.create(2, @board)
    game.current_player.should == "Computer"
    game.board.should == @board
  end

  it "returns user vs user game" do
    game = @game_factory.create(3, @board)
    game.current_player.should == "Human"
    game.board.should == @board
  end

end
