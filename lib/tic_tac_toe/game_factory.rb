require 'tic_tac_toe/game'
require 'tic_tac_toe/board'
require 'tic_tac_toe/player_factory'

module TicTacToe
  class GameFactory
    def initialize(player_factory = TicTacToe::PlayerFactory.new)
      @player_factory = player_factory
    end

    def types
      ["You vs Computer", "Computer vs You", "You vs Friend", "Computer vs Computer"]
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
      computer = @player_factory.computer(board)
      human = @player_factory.human
      TicTacToe::Game.new(board, computer, human)
    end

    def human_computer_game(board)
      computer = @player_factory.computer(board)
      human = @player_factory.human
      TicTacToe::Game.new(board, human, computer)
    end

    def human_human_game(board)
      human1 = @player_factory.human
      human2 = @player_factory.human("Friend", "O")
      TicTacToe::Game.new(board, human1, human2)
    end

    def computer_computer_game(board)
      computer1 = @player_factory.computer(board, "X", "O")
      computer2 = @player_factory.computer(board, "O", "X")
      TicTacToe::Game.new(board, computer1, computer2)
    end
  end
end
