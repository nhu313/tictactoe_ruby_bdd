require 'surrogate/rspec'
require 'tic_tac_toe/game_state'

class MockGameState
  Surrogate.endow(self)
  define_reader :board
  define_reader :current_player

  define :winner
  define :change_player
  define(:game_over?){true}
end

describe TicTacToe::GameState do
  it "checks MockGameState" do
    MockGameState.should be_substitutable_for(TicTacToe::GameState)
  end
end
