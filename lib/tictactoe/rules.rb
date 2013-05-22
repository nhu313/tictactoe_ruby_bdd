module TicTacToe
  class Rules
    def initialize(board)
      @board = board
    end
    
    def win?(player_value)
      winning_combinations.any? do |squares|
        player_marked_all_squares?(squares, player_value)
      end
    end
    
    def tied?(player_value)
      return false if win?(player_value)
      @board.filled?
    end
  
    private

    def winning_combinations
      @board.rows + @board.columns + @board.diagonals
    end
    
    def player_marked_all_squares?(squares, player_value)
      squares.all? {|square| square == player_value }
    end 
  end
end