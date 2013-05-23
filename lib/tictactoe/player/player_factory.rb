# require 'tictactoe/strategy/user_strategy'
# require 'tictactoe/strategy/minimax_strategy'
# require 'tictactoe/player/player'
# 
# module TicTacToe
#   
#   class PlayerFactory
#     def self.user(name, value, board)
#       strategy = TicTacToe::UserStrategy.new(board)
#       TicTacToe::Player.new(name, value, strategy)
#     end
#     
#     def self.computer(name, value, board)
#       strategy = TicTacToe::MinimaxStrategy.new(value, "O", board)
#       TicTacToe::Player.new(name, value, strategy)
#     end
#     
#   end
#   
# end