require 'tictactoe/ui/console'
require 'tictactoe/board'

describe TicTacToe::Console do
  before(:each) do
    @size = 2
    @output = StringIO.new
    @board = TicTacToe::Board.new(2)
    @console = TicTacToe::Console.new(@output, @board, "X")
  end
  
  it "displays welcome message" do
    @output.should_receive(:puts).with("Welcome to Tic Tac Toe!")
    @console.display_welcome_message
  end
  
  context "displays the board" do
    it "shows numbers for all unmarked squares" do
      expected_display = "| 0 | 1 |\n| 2 | 3 |\n"
      @output.should_receive(:puts).with(expected_display)
      @console.display_board
    end
    
    it "shows the player value on the marked square" do
      @board.mark(0, "X")
      expected_display = "| X | 1 |\n| 2 | 3 |\n"
      @output.should_receive(:puts).with(expected_display)
      @console.display_board
    end
    
    it "shows the player values when all the squares are marked" do
      (0...@size**2).each {|value| @board.mark(value, "O")}
      expected_display = "| O | O |\n| O | O |\n"
      @output.should_receive(:puts).with(expected_display)
      @console.display_board
    end
    
    it "displays a 3x3 board" do
      @board = TicTacToe::Board.new(3)
      @console = TicTacToe::Console.new(@output, @board, "X")
      expected_display = "| 0 | 1 | 2 |\n| 3 | 4 | 5 |\n| 6 | 7 | 8 |\n"
      @output.should_receive(:puts).with(expected_display)
      @console.display_board
    end
  end
  
  it "display that it is a tied game" do
    @output.should_receive(:puts).with("It's a tie!")
    @console.display_tied_game
  end
  
  it "displays winner" do
    player_name = "human"
    @output.should_receive(:puts).with("#{player_name} win!")
    @console.display_winner(player_name)
  end
end