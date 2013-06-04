module TicTacToe
  module Player
    class Human
      attr_reader :name

      def initialize(name, input = STDIN, output = STDOUT)
        @name = name
        @input = input
        @output = output
      end

      def move
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