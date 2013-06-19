require 'tic_tac_toe/game'
require 'tic_tac_toe/board'
require 'tic_tac_toe/rules'
require 'tic_tac_toe/ui/console'
require 'tic_tac_toe/player_factory'

module TicTacToe
  class GameFactory

    def types
      ["You vs Computer", "Computer vs You", "You vs Other You"]
    end

    def create(type_index)
      case type_index
      when 1
        human_computer_game
      when 2
        computer_human_game
      when 3
        human_human_game
      else
        raise ArgumentError, "Type does not exist. Please select a number corresponding to the game type."
      end
    end

    private
    def computer_human_game
      game = create_game
      game.player1 = TicTacToe::PlayerFactory.new.computer(game.board)
      game.player2 = TicTacToe::PlayerFactory.new.human

      game
    end

    def create_game
      board = TicTacToe::Board.new
      ui = TicTacToe::Console.new(board)
      TicTacToe::Game.new(board, ui)
    end

    def human_computer_game
      game = create_game
      game.player1 = TicTacToe::PlayerFactory.new.human
      game.player2 = TicTacToe::PlayerFactory.new.computer(game.board)

      game
    end

    def human_human_game
      game = create_game
      game.player1 = TicTacToe::PlayerFactory.new.human
      game.player2 = TicTacToe::PlayerFactory.new.human("Other you", "O")

      game
    end
  end
end
