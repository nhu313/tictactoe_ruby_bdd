require 'surrogate/rspec'

class MockGameFactory
  Surrogate.endow(self)
  define(:initialize) {|player_factory|}
  define :types
  define(:create) {|type, board|}
end
