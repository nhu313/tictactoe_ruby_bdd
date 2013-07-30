require 'tic_tac_toe/board'
require 'tic_tac_toe/rules'

module TicTacToe
  class GameState
    attr_reader :board, :current_player

    def initialize(players, board = TicTacToe::Board.new)
      @board = board
      @players = players
      @current_player = players[0]
    end

    def change_player
      @current_player = (@players[0] == @current_player)? @players[1] : @players[0]
    end

    def game_over?
      rules.game_over?
    end

    def winner
      player(rules.winner)
    end

    private
    def rules
      TicTacToe::Rules.new(board)
    end

    def player(value)
      @players.detect {|p| p.value == value}
    end
  end
end
