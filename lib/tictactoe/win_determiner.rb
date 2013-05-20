module TicTacToe
  class WinDeterminer
    
    def initialize(board)
      @board = board
    end
    
    def win?(player_value)
      return true if win_horizontally?(player_value)
      return true if win_vertically?(player_value)
      return true if win_diagonally?(player_value)
      false
    end
    
    # can I do this? Can I rely on the user to call win before tied?
    def tie?
      @board.filled?
    end
  
    private
    def win_vertically?(player_value)
      @board.columns.each do |col| 
        return true if player_marked_all_squares?(col, player_value)
      end
      false       
    end
    
    def win_horizontally?(player_value)
      @board.rows.each do |row| 
        return true if player_marked_all_squares?(row, player_value)
      end
      false      
    end
    
    def win_diagonally?(player_value)
      @board.diagonals.each do |squares|
        return true if player_marked_all_squares?(squares, player_value)
      end
      false
    end
    
    def player_marked_all_squares?(squares, player_value)
      squares.join() == player_value*@board.size
    end
    
  end
end