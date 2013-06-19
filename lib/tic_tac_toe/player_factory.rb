require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/strategy/human'
require 'tic_tac_toe/player'

module TicTacToe
  class PlayerFactory

    def human(name = "You", value = "X")
      TicTacToe::Player.new(name, value, TicTacToe::Strategy::Human.new)
    end

    def computer(board, value = "O", opponent_value = "X")
      ai = TicTacToe::Strategy::Minimax.new(board, value, opponent_value)
      TicTacToe::Player.new("Computer", value, ai)
    end
  end
end
