require 'tic_tac_toe/spec_helper'
require 'tic_tac_toe/ui/console'
require 'tic_tac_toe/board'

describe TicTacToe::Console do

  before(:each) do
    @size = 2
    @output = StringIO.new
    @input = StringIO.new
    @board = TicTacToe::Board.new(2)
    @console = TicTacToe::Console.new(@input, @output)
  end

  it "displays welcome message" do
    @output.should_receive(:puts).with("Welcome to Tic Tac Toe!")
    @console.display_welcome_message
  end

  it "displays message" do
    message = "A humanoid?"
    @console.display(message)
    @output.string.should match message
  end

  context "displays the board" do
    it "shows numbers for all unmarked squares" do
      expected_display = "| 0 | 1 |\n| 2 | 3 |\n"
      @output.should_receive(:puts).with(expected_display)
      @console.display_board(@board)
    end

    it "shows the player value on the marked square" do
      @board.mark(0, "X")
      expected_display = "| X | 1 |\n| 2 | 3 |\n"
      @output.should_receive(:puts).with(expected_display)
      @console.display_board(@board)
    end

    it "shows the player values when all the squares are marked" do
      (0...@size**2).each {|value| @board.mark(value, "O")}
      expected_display = "| O | O |\n| O | O |\n"
      @output.should_receive(:puts).with(expected_display)
      @console.display_board(@board)
    end

    it "displays a 3x3 board" do
      @board = TicTacToe::Board.new(3)
      @console = TicTacToe::Console.new(@input, @output)
      expected_display = "| 0 | 1 | 2 |\n| 3 | 4 | 5 |\n| 6 | 7 | 8 |\n"
      @output.should_receive(:puts).with(expected_display)
      @console.display_board(@board)
    end
  end

  context "reading user input for game type" do
    it "displays a list of game type" do
      expected_display = "1 - You vs Computer\n2 - Computer vs You\n3 - You vs Other You"
      @input.string = "1"
      @console.game_type
      @output.string.should match expected_display
    end

    it "displays a message asking user to select a game type" do
      expected_display = "Please select a game type."
      @input.string = "1"
      @console.game_type
      @output.string.should match expected_display
    end

    it "returns user input in integer" do
      @input.string = "1"
      @console.game_type.should == 1
    end

    # context "asks for input again when selection is invalid" do
    #   it "input is a character" do
    #     @input.stub(:gets).and_return("a", "2")
    #     @console.game_type.should == 2
    #   end
    #   # it "input is greater than the selection by a number"
    #   xit "input is a repeated number" do
    #     @input.string = "11 2"
    #     @console.game_type.should == 2
    #   end
    #
    # end
  end
end
