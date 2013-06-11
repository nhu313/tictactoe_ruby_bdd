$LOAD_PATH << File.expand_path('../../lib', __FILE__)
require 'tic_tac_toe'
require 'tic_tac_toe/mock/player'

player = MockPlayer.new([8, 6, 3])
game = TicTacToe::GameFactory.computer_user_game
game.start
