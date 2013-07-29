module TicTacToe
  class GameState
    attr_reader :board, :current_player

    def initialize(board, players)
      @board = board
      @players = players
      @current_player = players[0]
    end

    def change_player
      @current_player = (@players[0] == @current_player)? @players[1] : @players[0]
    end

    def player(value)
      @players.detect {|p| p.value == value}
    end
  end
end
