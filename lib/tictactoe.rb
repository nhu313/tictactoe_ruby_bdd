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
    rules = TicTacToe::Rules.new(board)
    
    human_options = Hash[:name => "You", :value => "O"]
    human = TicTacToe::HumanPlayer.new(human_options)
    
    computer_options = Hash[:name => "Computer", :opponent => human, 
                            :board => board, :rules => rules]
    computer = TicTacToe::ComputerPlayer.new(computer_options)
    
    ui = TicTacToe::Console.new(board, human)
    game = TicTacToe::Game.new(board, ui, rules)
    game.player1 = human
    game.player2 = computer
    
    rules.players = [human, computer]
    
    
    game
  end
  
end
end