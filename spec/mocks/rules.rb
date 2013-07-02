require 'surrogate/rspec'

class MockRules
  Surrogate.endow(self)
  define(:initialize) {|board|}
  define(:game_over?) {true}
  define(:tied?)
  define(:winner)
end

describe TicTacToe::Rules do
  it "checks if mock rules is substitutable" do
    MockRules.should be_substitutable_for(TicTacToe::Rules)
  end
end
