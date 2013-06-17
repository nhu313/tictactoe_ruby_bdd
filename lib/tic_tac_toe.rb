require 'tic_tac_toe/game'
require 'tic_tac_toe/board'
require 'tic_tac_toe/rules'
require 'tic_tac_toe/ui/console'
require 'tic_tac_toe/strategy/minimax'
require 'tic_tac_toe/strategy/human'
require 'tic_tac_toe/player'

module TicTacToe
class GameFactory

  def self.computer_user_game
    board = TicTacToe::Board.new

    human = TicTacToe::Player.new("You", "X", TicTacToe::Strategy::Human.new)

    ai = TicTacToe::Strategy::Minimax.new(board, "O", "X")
    computer = TicTacToe::Player.new("Computer", "O", ai)

    ui = TicTacToe::Console.new(board)
    game = TicTacToe::Game.new(board, ui)
    game.player1 = human
    game.player2 = computer

    game
  end

end
end
