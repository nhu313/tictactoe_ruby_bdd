require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/game_factory'
require 'tic_tac_toe/player_factory'
require 'tic_tac_toe/player'
require 'mocks/player_factory'

describe TicTacToe::GameFactory do
  before(:each) do
    @player_factory = MockPlayerFactory.new
    @game_factory = TicTacToe::GameFactory.new(@player_factory)
  end

  it "returns 4 types of games" do
    @game_factory.types.size.should == 4
  end

  context "creates game" do
    before(:each) do
      @human = TicTacToe::Player.new("Human", TicTacToe::VALUES[0], nil)
      @computer = TicTacToe::Player.new("Computer", opponent_value(@human.value), nil)
    end

    def test_game_state_creation(game_type, players)
      @player_factory.will_create players[0], players[1]

      game = @game_factory.create(game_type)
      game.current_player.should == players[0]
      game.make_player_move(1)
      game.current_player.should == players[1]
    end

    it "returns user vs user game" do
      @human2 = TicTacToe::Player.new("Human 2", opponent_value(@human.value), nil)
      test_game_state_creation(1, [@human, @human2])
    end

    it "returns human vs computer game" do
      test_game_state_creation(2, [@human, @computer])
    end

    it "returns computer vs human game" do
      test_game_state_creation(3, [@computer, @human])
    end

    it "returns computer vs computer game" do
      @computer2 = TicTacToe::Player.new("Computer 2", opponent_value(@computer.value), nil)
      test_game_state_creation(4, [@computer, @computer2])
    end

  it "raises an error when the game type doesn't exist" do
    lambda{@game_factory.create(10)}.should raise_error(ArgumentError)
  end

  end

  def opponent_value(value)
    TicTacToe::Values.opponent(value)
  end
end
