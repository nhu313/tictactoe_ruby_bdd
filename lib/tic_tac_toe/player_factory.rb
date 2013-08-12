require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/strategy/console_user'
require 'tic_tac_toe/player'
require 'tic_tac_toe/values'

module TicTacToe
  class PlayerFactory

    def types
      [:human, :computer]
    end

    def create(player_type, value)
      case player_type
      when :human
        human(value)
      when :computer
        computer(value)
      end
    end

    private
    def human(value)
      TicTacToe::Player.new("User", value, TicTacToe::Strategy::ConsoleUser.new)
    end

    def computer(value)
      ai = TicTacToe::Strategy::Minimax.new(value)
      TicTacToe::Player.new("Computer", value, ai)
    end
  end
end
