require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/rules'
require 'tictactoe/ui/console'
require 'tictactoe/player/human'
require 'tictactoe/player/computer'

module TicTacToe
class GameFactory

  def self.computer_user_game
    board = TicTacToe::Board.new

    human = TicTacToe::Player::Human.new("You")
    computer = TicTacToe::Player::Computer.new("Computer", board, human)

    ui = TicTacToe::Console.new(board, human)
    game = TicTacToe::Game.new(board, ui)
    game.player1 = human
    game.player2 = computer

    game
  end

end
end