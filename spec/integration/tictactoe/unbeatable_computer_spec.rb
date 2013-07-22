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
    play_game_for_each_available_move(@board)
  end

  it "wins all game when human goes first" do
    play_game_for_each_available_move(@board)
  end

  def make_computer_move(clone_board)
    computer = TicTacToe::PlayerFactory.new.computer(clone_board)
    clone_board.mark(computer.move, computer.value)
    clone_board
  end

  def rules(board)
    TicTacToe::Rules.new(board)
  end

  def play_game_for_each_available_move(board, move_history=[])
    if rules(board).game_over?
      print "."
      if rules(board).winner == @human_value
        raise "Human wins: #{move_history.inspect}"
      end
    else
      board.available_moves.each do |move|
        make_players_move(board.clone, move_history.dup, move)
      end
    end
  end

  def make_players_move(board, move_history, move)
    move_history << move
    board.mark(move, "X")
    make_computer_move(board) if !rules(board).game_over?
    play_game_for_each_available_move(board, move_history)
  end
end
