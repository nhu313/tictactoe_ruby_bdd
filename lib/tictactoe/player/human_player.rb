module TicTacToe
  class HumanPlayer
    
    attr_reader :name, :value

    def initialize(options)
      @name = name
      @value = value
    end
    
    
    
    # def initialize(input=STDIN, output=STDOUT, board)
    #   @input = input
    #   @output = output
    #   @board = board
    # end
    
    def move
      move = nil
      
      until move =~ NUMBER
        display_get_input
        move = @input.gets
      end
      
      move.to_i
    end
    
    private 
    NUMBER = /\d/
    
    def display_get_input
      @output.puts("Please enter a square number that is not marked: ")
    end
  end
end