module TicTacToe
  class HumanPlayer
    attr_reader :name, :value
    
    def initialize(options)
      @name = options[:name]
      @value = options[:value]
      @output = options[:output] || STDOUT
      @input = options[:input] || STDIN
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