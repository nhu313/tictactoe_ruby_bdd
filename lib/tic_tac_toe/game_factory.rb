require 'tic_tac_toe/game'
require 'tic_tac_toe/board'
require 'tic_tac_toe/player_factory'

module TicTacToe
  class GameFactory
    def initialize(player_factory = TicTacToe::PlayerFactory.new)
      @player_factory = player_factory
    end

    def types
      [[:human, :computer], [:computer, :human], [:human, :human], [:computer, :computer]]
    end

    def create(type_index, board)
      case type_index
      when 1
        human_computer_game(board)
      when 2
        computer_human_game(board)
      when 3
        human_human_game(board)
      when 4
        computer_computer_game(board)
      else
        raise ArgumentError, "Type does not exist. Please select a number corresponding to the game type."
      end
    end

    private
    def computer_human_game(board)
      create_game(board, @player_factory.computer(board), @player_factory.human)
    end

    def human_computer_game(board)
      create_game(board, @player_factory.human, @player_factory.computer(board))
    end

    def human_human_game(board)
      create_game(board, @player_factory.human, @player_factory.human("Friend", "O"))
    end

    def computer_computer_game(board)
      create_game(board, @player_factory.computer(board, "X", "O"), @player_factory.computer(board, "O", "X"))
    end

    def create_game(board, player1, player2)
      TicTacToe::Game.new(board, player1, player2)
    end
  end
end
