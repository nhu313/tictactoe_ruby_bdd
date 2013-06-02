require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/rules'
require 'tictactoe/ui/console'
require 'tictactoe/player/human_player'
require 'tictactoe/player/computer_player'

module TicTacToe
class GameFactory
  
  def self.computer_user_game
    board = TicTacToe::Board.new
    ui = TicTacToe::Console.new(board)
    rules = TicTacToe::Rules.new(board)
    game = TicTacToe::Game.new(board, ui, rules)
    
    
    human_options = Hash[:name => "You", :value => "O"]
    game.player1 = TicTacToe::HumanPlayer.new(human_options)
    
    computer_options = Hash[:name => "Computer", :player => "X", 
                            :opponent => "O", :board => board, :rules => rules, 
                            :value => "X"]
    game.player2 = TicTacToe::ComputerPlayer.new(computer_options)
    
    game
  end
  
end
end