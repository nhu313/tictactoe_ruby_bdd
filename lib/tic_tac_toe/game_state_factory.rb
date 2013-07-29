require 'tic_tac_toe/game_state'
require 'tic_tac_toe/board'
require 'tic_tac_toe/player_factory'
require 'tic_tac_toe/values'

module TicTacToe
  class GameStateFactory
    def initialize(player_factory = TicTacToe::PlayerFactory.new)
      @player_factory = player_factory
    end

    def types
      [[:human, :computer], [:computer, :human], [:human, :human], [:computer, :computer]]
    end

    def create(game_type)
      case game_type
      when 1
        human_computer_game
      when 2
        computer_human_game
      when 3
        human_human_game
      when 4
        computer_computer_game
      else
        raise ArgumentError, "Type #{game_type} does not exist. Please select a number corresponding to the game type."
      end
    end

    private
    def computer_human_game
      create_game(@player_factory.computer, @player_factory.human)
    end

    def human_computer_game
      create_game(@player_factory.human, @player_factory.computer)
    end

    def human_human_game
      player1 = @player_factory.human
      player2 = @player_factory.human("Friend", TicTacToe::Values.opponent(player1.value))
      create_game(player1, player2)
    end

    def computer_computer_game
      computer1 = @player_factory.computer(TicTacToe::VALUES[0])
      computer2 = @player_factory.computer(TicTacToe::Values.opponent(computer1.value))
      create_game(computer1, computer2)
    end

    def create_game(player1, player2)
      TicTacToe::GameState.new([player1, player2])
    end
  end
end
