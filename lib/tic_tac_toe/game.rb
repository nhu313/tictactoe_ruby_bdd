module TicTacToe
  class Game
    attr_reader :current_player, :board

    def initialize(board, player1, player2)
      @board = board
      @current_player = @player1 = player1
      @player2 = player2
    end

    def move
      player_move = @current_player.move
      if player_move
        @board.mark(player_move, @current_player.value)
        change_player
      end
    end

    def result_msg(winner_mark)
      winner = player(winner_mark)
      if winner
        "#{winner.name} win!"
      else
        "It's a tie!"
      end
    end

    private
    def change_player
      @current_player = (@current_player == @player1) ? @player2 : @player1
    end

    def player(mark)
      return nil if !mark
      return @player1 if mark == @player1.value
      @player2
    end
  end
end
