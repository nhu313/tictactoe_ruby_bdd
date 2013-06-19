require 'tic_tac_toe/game_factory'

module TicTacToe
  class Console

    def initialize(input = STDIN, output=STDOUT, board)
      @input = input
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

    def game_type
      @output.puts("Please select a game type.")
      @output.puts(game_type_list)
      type = @input.gets
      type.to_i
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

    def game_type_list
      result = ""
      TicTacToe::GameFactory.new.types.each_with_index do |value, index|
        result << "#{index + 1} - #{value}\n"
      end
      result
    end
  end
end
