require 'tic_tac_toe/game_state_factory'

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

    def game_type
      @output.puts("Please enter a game type from the list.")
      @output.puts(game_type_list)
      type = @input.gets
      if type =~ /\d/
        type.to_i
      else
        game_type
      end
    end

    def display_winner(winner)
      @output.puts("#{winner.name}(#{winner.value}) win!")
    end

    def display_tied_game
      @output.puts("Tied!")
    end

    def display_square_not_available
      @output.puts("Square is not available. Please enter a different square.")
    end

    def display_player_turn(player)
      @output.puts("It's #{player.name}(#{player.value}) turn.")
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
      TicTacToe::GameStateFactory.new.types.each_with_index.map do |value, index|
        result << "#{index + 1} - #{game_type_values(value)}\n"
      end
      result
    end

    def game_type_values(types)
      "#{player_type(types[0])} vs #{player_type(types[1])}"
    end

    def player_type(type)
      return "Human" if type == :human
      return "Computer" if type == :computer
    end
  end
end
