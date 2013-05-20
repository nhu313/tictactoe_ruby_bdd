require 'tictactoe/strategy/user_strategy'
require 'tictactoe/player/player'

module TicTacToe
  
  class PlayerFactory
    def self.user(name, value, board)
      strategy = TicTacToe::UserStrategy.new(board)
      TicTacToe::Player.new(name, value, strategy)
    end
    
    def self.computer(value, board)
      
      
    end
    
  end
  
end