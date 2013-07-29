module TicTacToe
  module Strategy
    class ConsoleUser

      def initialize(input = STDIN, output = STDOUT)
        @input = input
        @output = output
      end

      def move(*board)
        move = nil

        until move =~ NUMBER
          @output.puts("Please enter a square number that is not marked: ")
          move = @input.gets
        end

        move.to_i
      end

      private
      NUMBER = /\d/

    end
  end
end
