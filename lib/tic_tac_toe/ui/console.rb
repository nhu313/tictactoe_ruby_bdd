require 'tic_tac_toe/game_factory'

module TicTacToe
  class Console

    def initialize(input = STDIN, output=STDOUT)
      @input = input
      @output = output
    end

    def display_welcome_message
      @output.puts("Welcome to Tic Tac Toe!")
    end

    def display_board(board)
      @output.puts(build_board(board))
    end

    def display(message)
      @output.puts(message)
    end

    def game_type
      @output.puts("Please select a game type.")
      @output.puts(game_type_list)
      type = @input.gets
      type.to_i
    end

    private
    def build_board(board)
      result = ""
      board.squares.each_with_index do |value, index|
         result << "| #{value || index} "
         result << "|\n" if (index + 1) % board.size == 0
      end
      result
    end

    def game_type_list
      result = ""
      TicTacToe::GameFactory.new.types.each_with_index do |value, index|
        result << "#{index + 1} - #{value}\n"
      end
      result
    end
  end
end
