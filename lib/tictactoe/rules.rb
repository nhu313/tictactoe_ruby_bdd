module TicTacToe
  class Rules    
    def initialize(board)
      @board = board
    end

    def game_over?
      return true if winner
      return true if @board.filled?
      false
    end
    
    def tied?
      !winner && @board.filled?
    end
    
    def winner
      @board.unique_marked_values.detect {|p| win?(p)}
    end

    private
    def win?(player)
      square_sets.any? do |squares|
        squares.all? {|square| square == player}
      end
    end
    
    def square_sets
      @board.rows + @board.columns + @board.diagonals
    end
  end
end