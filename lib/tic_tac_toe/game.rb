require 'tic_tac_toe/board'
require 'tic_tac_toe/rules'

module TicTacToe
  class Game
    attr_reader :board, :current_player

    def initialize(players, board = TicTacToe::Board.new)
      @board = board
      @players = players
      @current_player = players[0]
    end

    def game_over?
      rules.game_over?
    end

    def winner
      player(rules.winner)
    end

    def make_player_move(*move)
      player_move = move[0] || @current_player.move(board)
      if player_move
        @board.mark(player_move, @current_player.value)
        change_player
      end
    end

    private
    def rules
      @rules ||= TicTacToe::Rules.new(board)
    end

    def player(value)
      @players.detect {|p| p.value == value}
    end

    def change_player
      @current_player = (@players[0] == @current_player)? @players[1] : @players[0]
    end
  end
end
