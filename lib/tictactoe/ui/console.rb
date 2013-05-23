module TicTacToe
  class Console
    
    def initialize(output=STDOUT, board)
      @output = output
      @board = board
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
         result << "| #{value || index} "
         result << "|\n" if (index + 1) % @board.size == 0
      end
      result      
    end
  end
end