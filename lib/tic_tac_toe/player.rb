module TicTacToe
  class Player
    attr_reader :name, :value, :strategy

    def initialize(name, value, strategy)
      @name = name
      @value = value
      @strategy = strategy
    end

    def move(board)
      strategy.move(board)
    end
  end
end
