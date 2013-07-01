require 'tic_tac_toe/rules'

module TicTacToe
  class Game
    attr_reader :current_player, :board

    def initialize(board, player1, player2)
      @board = board
      @current_player = @player1 = player1
      @player2 = player2
      @rules = TicTacToe::Rules.new(@board)
    end

    def make_move
      player_move = @current_player.move
      if player_move
        @board.mark(player_move, @current_player.value)
        change_player
      end
    end

    def over?
      @rules.game_over?
    end

    def winner
      player(@rules.winner)
    end

    private
    def change_player
      @current_player = (@current_player == @player1) ? @player2 : @player1
    end

    def player(mark)
      return @player1 if mark == @player1.value
      return @player2 if mark == @player2.value
    end

  end
end
