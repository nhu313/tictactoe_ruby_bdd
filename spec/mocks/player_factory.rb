require 'surrogate/rspec'
require 'tic_tac_toe/values'

class MockPlayerFactory
  Surrogate.endow(self)

  define(:human) {|name = "human", value = TicTacToe::VALUES[0]|}
  define(:computer) {|board, value = TicTacToe::VALUES[1]|}
end

describe TicTacToe::PlayerFactory do
  it "checks mock player" do
    MockPlayerFactory.should be_substitutable_for(TicTacToe::PlayerFactory)
  end
end
