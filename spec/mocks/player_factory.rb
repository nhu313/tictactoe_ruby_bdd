require 'surrogate/rspec'

class MockPlayerFactory
  Surrogate.endow(self)

  define(:human) {|name = "Sue", value = "X"|}
  define(:computer) {|board, value = "X", opponent="O"|}
end

describe TicTacToe::PlayerFactory do
  it "checks mock player" do
    MockPlayerFactory.should be_substitutable_for(TicTacToe::PlayerFactory)
  end
end
