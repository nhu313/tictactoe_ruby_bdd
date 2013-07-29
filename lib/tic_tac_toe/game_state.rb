module TicTacToe
  class GameState
    attr_reader :board, :current_player

    def initialize(board, players)
      @board = board
      @current_player = @player1 = players[0]
      @player2 = players[1]
    end

    def change_player
      @current_player = (@player1 == @current_player)? @player2 : @player1
    end
  end
end
