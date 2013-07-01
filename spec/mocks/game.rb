require 'surrogate/rspec'

class MockGame
  Surrogate.endow(self)
  define_reader :board
  define_reader :current_player

  define :make_move
  define :winner
  define(:over?){true}
end
