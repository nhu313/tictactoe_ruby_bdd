require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/ui/console'
require 'tictactoe/win_determiner'
require 'tictactoe/player/player'
require 'tictactoe/player/player_factory'

module TicTacToe
class GameFactory
  
  def self.computer_user_game
    board = TicTacToe::Board.new
    ui = TicTacToe::Console.new(board)
    win_determiner = TicTacToe::WinDeterminer.new(board)
    game = TicTacToe::Game.new(board, ui, win_determiner)
    
    game.player1 = TicTacToe::PlayerFactory.user("You", "X", board)
    game.player2 = TicTacToe::PlayerFactory.user("Computer", "O", board)
    
    game
  end
  
end
end