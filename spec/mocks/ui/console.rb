require 'surrogate/rspec'

class MockConsole

  Surrogate.endow(self)

  define :display_welcome_message
  define(:display_board) {|board|}
  define(:display) {|message|}
  define :game_type
  define(:display_winner){|winner|}
  define :display_tied_game
  define :display_square_not_available
  define(:display_player_turn) {|player|}
end

describe TicTacToe::Console do
  it "checks console" do
    MockConsole.should be_substitutable_for(TicTacToe::Console)
  end
end
