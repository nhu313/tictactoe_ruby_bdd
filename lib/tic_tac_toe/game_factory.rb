require 'tic_tac_toe/game'
require 'tic_tac_toe/board'
require 'tic_tac_toe/player_factory'

module TicTacToe
  class GameFactory
    attr_reader :player_factory

    def initialize
      @player_factory = TicTacToe::PlayerFactory.new
    end

    def types
      ["You vs Computer", "Computer vs You", "You vs Other You"]
    end

    def create(type_index, board)
      case type_index
      when 1
        human_computer_game(board)
      when 2
        computer_human_game(board)
      when 3
        human_human_game(board)
      else
        raise ArgumentError, "Type does not exist. Please select a number corresponding to the game type."
      end
    end

    private
    def computer_human_game(board)
      computer = player_factory.computer(board)
      human = player_factory.console_user
      TicTacToe::Game.new(board, computer, human)
    end

    def human_computer_game(board)
      computer = player_factory.computer(board)
      human = player_factory.console_user
      TicTacToe::Game.new(board, human, computer)
    end

    def human_human_game(board)
      human1 = player_factory.console_user
      human2 = player_factory.console_user("You", "O")
      TicTacToe::Game.new(board, human1, human2)
    end
  end
end
