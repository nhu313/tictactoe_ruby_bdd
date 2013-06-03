module TicTacToe
  class Player
    
    def initialize(strategy)
      @strategy = strategy
    end
    
    def move
      @strategy.move
    end
    
  end
end