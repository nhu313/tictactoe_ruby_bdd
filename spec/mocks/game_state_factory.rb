require 'surrogate/rspec'

class MockGameStateFactory
  Surrogate.endow(self)
  define(:initialize) {|player_factory|}
  define :types
  define(:create) {|type|}
end

describe TicTacToe::GameStateFactory do
  it "checks game factory" do
    MockGameStateFactory.should be_substitutable_for(TicTacToe::GameStateFactory)
  end
end
