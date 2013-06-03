module TicTacToe
  class Console
    
    def initialize(output=STDOUT, board, playerX)
      @output = output
      @board = board
      @playerX = playerX
    end
    
    def display_welcome_message
      @output.puts("Welcome to Tic Tac Toe!")
    end
    
    def display_board
      @output.puts(build_board)
    end
    
    def display_tied_game
      @output.puts("It's a tie!")
    end
    
    def display_winner(player_name)
      @output.puts("#{player_name} win!")
    end
    
    private    
    def build_board
      result = ""
      @board.squares.each_with_index do |value, index|
         result << "| #{player_value(value) || index} "
         result << "|\n" if (index + 1) % @board.size == 0
      end
      result      
    end
    
    def player_value(value)
      return nil if !value
      (value == @playerX) ? "X" : "O"
    end
  end
end