require 'tictactoe/player/computer_player'
require 'tictactoe/board'
require 'tictactoe/rules'

describe TicTacToe::ComputerPlayer do

  before(:each) do
    @board = TicTacToe::Board.new(3)
    @output = StringIO.new
    rules = TicTacToe::Rules.new(@board)
    @player_mark = "X"
    @opponent_mark = "O"
    
    @options = Hash[:output => @output, :board => @board, :rules => rules, 
                    :player => @player_mark, :opponent => @opponent_mark]
                    
    @player = TicTacToe::ComputerPlayer.new(@options)
  end
  
  context "move" do
    context "when there is only one position left" do    
      it "returns move with score of 1 when it's a winning move" do
        mark((1...@board.size**2), @player_mark)
        @player.move.should == 0
      end
  
      it "returns the move with score of 0 when it's a tied" do
        mark([0, 2, 5, 6], @player_mark)
        mark([1, 3, 4, 8], @opponent_mark)
        @player.move.should == 7
      end
  
      it "returns the move with score of -1 when opponent wins" do
        mark((0...@board.size**2 - 1).to_a, @opponent_mark)
        @player.move.should == 8
      end
    end

    context "minimax when there are two positions left" do
      it "returns losing scores when the two moves are losing moves" do
        mark((2...@board.size**2).to_a, @opponent_mark)
        @player.move.should == 0
      end
      
      it "returns the first win move when the two moves are winning moves" do
        mark((2...@board.size**2).to_a, @player_mark)
        @player.move.should == 0
      end
      
      it "returns the first tie move when the two moves are tie moves" do
        mark([0, 2, 7], @player_mark)
        mark([1, 4, 6, 8], @opponent_mark)
        @player.move.should == 3
      end
      
      it "returns win move when there are winning and losing moves" do
        mark([0, 1, 3, 7], @player_mark)
        mark([2, 4, 5], @opponent_mark)
        @player.move.should == 6
      end
      
      it "returns winning move when there are winning and tie moves" do
        mark([0, 2, 3, 4], @player_mark)
        mark([1, 5, 8], @opponent_mark)
        @player.move.should == 6
      end
      
      it "returns tied move when there are losing and tie moves" do
        mark([2, 3, 4], @player_mark)
        mark([0, 5, 6, 7], @opponent_mark)
        @player.move.should == 8
      end 
    end

    context "when there are three moves left" do
      it "chooses the winning move when there is one available" do
        mark([1, 4], @player_mark)
        mark([0, 3, 2, 5], @opponent_mark)
        @player.move.should == 7
      end
    
      it "chooses a tie move when there are only losing and tie moves" do
        mark([1, 3, 5], @player_mark)
        mark([0, 2, 4], @opponent_mark)
        @player.move.should == 6
      end
    end
    
    context "when there are 4 moves left" do
      it "chooses a winning move when one is available" do
        mark([4, 8], @player_mark)
        mark([1, 2, 6], @opponent_mark)
        @player.move.should == 0
      end
      
      it "chooses a move that would create 2 winning moves" do
        mark([0, 6], @player_mark)
        mark([1, 3, 5], @opponent_mark)
        @player.move.should == 4
      end
      
    end
  end


  def move_node(move, score)
    TicTacToe::Move.new(move, score)
  end

  def mark(squares, value)
    squares.each {|i| @board.mark(i, value)}
  end
end