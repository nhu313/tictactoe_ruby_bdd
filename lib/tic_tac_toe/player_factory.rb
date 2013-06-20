require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/strategy/console_user'
require 'tic_tac_toe/player'

module TicTacToe
  class PlayerFactory

    def console_user(name = "User", value = "X")
      TicTacToe::Player.new(name, value, TicTacToe::Strategy::ConsoleUser.new)
    end

    def computer(board, value = "O", opponent_value = "X")
      ai = TicTacToe::Strategy::Minimax.new(board, value, opponent_value)
      TicTacToe::Player.new("Computer", value, ai)
    end
  end
end
