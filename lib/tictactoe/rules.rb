module TicTacToe
  class Rules
    def initialize(board)
      @board = board
    end
    
    def win?(player)
      square_sets.any? do |squares|
        marked_all_squares?(squares, player)
      end
    end
    
    def tied?(player)
      return false if win?(player)
      @board.filled?
    end
  
    private
    def square_sets
      @board.rows + @board.columns + @board.diagonals
    end
    
    def marked_all_squares?(squares, player)
      squares.all? {|square| square == player}
    end 
  end
end