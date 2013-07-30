require 'surrogate/rspec'

class MockPlayer
  Surrogate.endow(self)
  define(:initialize) {|name = "Player", value = "X", strategy = "no"|}
  define_reader :name
  define_reader :value
  define_reader :strategy
  define(:move) {|board|}
end

describe TicTacToe::Player do
  it "checks if mock is substitutable" do
    MockPlayer.should be_substitutable_for(TicTacToe::Player)
  end
end
