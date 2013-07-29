require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/strategy/console_user'
require 'tic_tac_toe/player'

module TicTacToe
  class PlayerFactory

    def human(name = "User", value = TicTacToe::VALUES[0])
      TicTacToe::Player.new(name, value, TicTacToe::Strategy::ConsoleUser.new)
    end

    def computer(value = TicTacToe::VALUES[1])
      ai = TicTacToe::Strategy::Minimax.new(value)
      TicTacToe::Player.new("Computer", value, ai)
    end
  end
end
