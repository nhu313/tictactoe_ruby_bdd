require 'tic_tac_toe/board'
require 'tic_tac_toe/rules'
require 'tic_tac_toe/player_factory'

class SimpleStrategy
  attr_accessor :next_move

  def move
    next_move
  end
end

describe "Unbeatable computer", :slow_test => true  do
  before(:each) do
    @board = TicTacToe::Board.new
    @human_value = "X"
  end

  it "wins all game when computer goes first" do
    make_computer_move(@board)
    make_move(@board, [])
  end

  it "wins all game when human goes first" do
    make_move(@board, [])
  end

  def make_computer_move(clone_board)
    computer = TicTacToe::PlayerFactory.new.computer(clone_board)
    clone_board.mark(computer.move, computer.value)
    clone_board
  end

  def rules(board)
    TicTacToe::Rules.new(board)
  end

  def make_move(board, move_history)
    if rules(board).game_over?
      print "."
      if rules(board).winner == @human_value
        print move_history
        raise "Human wins."
      end
    else
      board.available_moves.each do |move|
        move_history << move
        cloned_board = board.clone
        cloned_board.mark(move, "X")
        make_computer_move(cloned_board) if !rules(cloned_board).game_over?
        make_move(cloned_board, move_history)
        move_history.delete(move)
      end
    end
  end


end
