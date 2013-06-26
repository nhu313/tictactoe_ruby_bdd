require 'surrogate/rspec'

class MockRules
  Surrogate.endow(self)
  define(:initialize) {|board|}
  define(:game_over?) {true}
  define(:tied?)
  define(:winner)
end
