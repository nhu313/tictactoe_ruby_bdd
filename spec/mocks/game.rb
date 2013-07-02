require 'surrogate/rspec'

class MockGame
  Surrogate.endow(self)
  define_reader :board
  define_reader :current_player

  define :make_move
  define :winner
  define(:over?){true}
end

describe TicTacToe::Game do
  it "checks MockGame" do
    MockGame.should be_substitutable_for(TicTacToe::Game)
  end
end
