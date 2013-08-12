require 'surrogate/rspec'
require 'tic_tac_toe/values'

class MockPlayerFactory
  Surrogate.endow(self)

  define(:create){|player_type, value|}
  define(:types){TicTacToe::PlayerFactory.new.types}
end

describe TicTacToe::PlayerFactory do
  it "checks mock player" do
    MockPlayerFactory.should be_substitutable_for(TicTacToe::PlayerFactory)
  end
end
