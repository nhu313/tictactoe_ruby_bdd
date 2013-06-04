require 'tic_tac_toe/game'
require 'tic_tac_toe/board'
require 'tic_tac_toe/rules'
require 'tic_tac_toe/ui/console'
require 'tic_tac_toe/player/human'
require 'tic_tac_toe/player/computer'

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