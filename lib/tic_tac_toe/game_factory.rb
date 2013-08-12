require 'tic_tac_toe/game'
require 'tic_tac_toe/board'
require 'tic_tac_toe/player_factory'
require 'tic_tac_toe/values'

module TicTacToe
  class GameFactory
    def initialize(player_factory = TicTacToe::PlayerFactory.new)
      @player_factory = player_factory
    end

    def types
      player_types = @player_factory.types
      player_types.product player_types
    end

    def create(game_type)
      player_types = types[game_type-1]

      if player_types
        player1 = @player_factory.create(player_types[0], TicTacToe::VALUES[0])
        player2 = @player_factory.create(player_types[1], TicTacToe::VALUES[1])
        TicTacToe::Game.new([player1, player2])
      else
        raise ArgumentError, "Type #{game_type} does not exist. Please select a number corresponding to the game type."
      end
    end
  end
end
