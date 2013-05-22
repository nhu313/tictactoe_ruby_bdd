require 'tictactoe/board'
require 'tictactoe/strategy/minimax_strategy'

describe TicTacToe::MinimaxStrategy do
  
  before(:each) do
    @player_value = "X"
    @opponent_value = "O"
    @board = TicTacToe::Board.new(3)
    @minimax = TicTacToe::MinimaxStrategy.new(@player_value, @opponent_value, @board)    
  end
  
  xit "returns the last move when the board has one move left" do
    mark((1...@board.size**2), "X")
    @minimax.move.should == 0
  end
  
  context "when there are two moves left" do
    xit "chooses the winning move when it exist" do
      mark([0, 4, 5, 6], @player_value)
      mark([1, 2, 3], @opponent_value)
      @minimax.move.should == 8
    end
    
    xit "blocks the winning move when there is no winning move" do
      mark([3, 6, 8], "X")
      mark([0, 2, 4, 7], "O")
      @minimax.move.should == 1
    end
    
    
  end
  
  context "3x3 board" do
    xit "is the winning move the choice is the draw and the winning move" do
      mark([0, 4, 6], "X")
      mark([2, 3, 7], "O")
      @minimax.move.should == 8
    end
    
    it "is the blocking move when there is no winning move and other player could win" do
      
    end
    
    
  end
  
  xit "nothing" do

    board = TicTacToe::Board.new(3)

    board1 = board.dup

    board.mark(0, "m")
    puts(board.squares)
    puts(board1.squares)
  end
  
  context "" do
    
  end

  context "get maximum move" do
    it "returns the maximum move when max move is the only move" do
      move = move_node(1, 4)
      @minimax.max_move([move]).should == move
    end
    
    it "returns the maximum move when max is the first element" do
      max_move = move_node(1, 4)
      other_move = move_node(2, 2)
      @minimax.max_move([max_move, other_move]).should == max_move
    end
    
    it "returns the maximum move when max is the last element" do
      max_move = move_node(1, 4)
      other_move = move_node(2, 2)
      @minimax.max_move([other_move, max_move]).should == max_move
    end
    
    it "returns the maximum move when max is the middle element" do
      max_move = move_node(1, 4)
      first = move_node(2, 2)
      last = move_node(2, 3)
      @minimax.max_move([first, max_move, last]).should == max_move
    end
  end
  
  context "get minimum move" do
    it "returns the minimum move when min move is the only move" do
      move = move_node(1, 4)
      @minimax.min_move([move]).should == move
    end
    
    it "returns the minimum move when min is the first element" do
      min_move = move_node(1, 1)
      other_move = move_node(2, 2)
      @minimax.min_move([min_move, other_move]).should == min_move
    end
    
    it "returns the minimum move when max is the last element" do
      min_move = move_node(1, 3)
      other_move = move_node(2, 5)
      @minimax.min_move([other_move, min_move]).should == min_move
    end
    
    it "returns the minimum move when max is the middle element" do
      min_move = move_node(1, 3)
      first = move_node(2, 7)
      last = move_node(2, 4)
      @minimax.min_move([first, min_move, last]).should == min_move
    end
    
    it "returns one minimum move when there are 2 with the same score" do
      min_move = move_node(1, 3)
      min_move2 = move_node(1, 3)
      @minimax.min_move([min_move, min_move2]).should == min_move
    end
  end
  
  context "score value" do
    it "is 1 when player wins" do
      mark([0, 1, 2], @player_value)
      @minimax.score.should == 1
    end
    
    it "is -1 when opponent wins" do
      mark([0, 1, 2], @opponent_value)
      @minimax.score.should == -1      
    end
    
    it "is nil when game is not over" do
      @minimax.score.should == nil
    end
    
    it "is 0 when it is tie" do
      mark([0, 2, 5, 6, 7], @opponent_value)
      mark([1, 3, 4, 8], @player_value)
      @minimax.score.should == 0
    end
  end
  
  context "minimax when there is only one position left" do    
    it "returns move with score of 1 when it's a winning move" do
      mark((1...@board.size**2), "X")
      move = move_node(0, 1)
      @minimax.minimax.should == [move]
    end
    
    it "returns the move with score of 0 when it's a tied" do
      mark([0, 2, 5, 6], @player_value)
      mark([1, 3, 4, 8], @opponent_value)
      move = move_node(7, 0)      
      @minimax.minimax.should == [move]
    end
    
    it "returns the move with score of -1 when opponent wins" do
      mark((0...@board.size**2 - 1).to_a, @opponent_value)
      move = move_node(8, -1)
      @minimax.minimax.should == [move]
    end
  end
  
  context "minimax when there are two positions left" do
    it "returns losing scores when the two moves are losing moves" do
      mark((2...@board.size**2).to_a, @opponent_value)
      move1 = move_node(0, -1)
      move2 = move_node(1, -1)
      @minimax.minimax.should == [move1, move2]
    end
    
    it "returns winning scores when the two moves are winning moves" do
      mark((2...@board.size**2).to_a, @player_value)
      move1 = move_node(0, 1)
      move2 = move_node(1, 1)
      @minimax.minimax.should == [move1, move2]
    end
    
    it "returns tie scores when the two moves are tie moves" do
      mark([0, 2, 7], @player_value)
      mark([1, 4, 6, 8], @opponent_value)
      move1 = move_node(3, 0)
      move2 = move_node(5, 0)
      @minimax.minimax.should == [move1, move2]
    end
    
    it "returns moves when there are winning and losing moves" do
      mark([0, 1, 3, 7], @player_value)
      mark([2, 4, 5], @opponent_value)
      winning_move = move_node(6, 1)
      losing_move = move_node(8, -1)
      
      @minimax.minimax.should == [winning_move, losing_move]
    end
    
    it "returns moves when there are winning and tie moves" do
      mark([0, 2, 3, 4], @player_value)
      mark([1, 5, 8], @opponent_value)
      winning_move = move_node(6, 1)
      tie_move = move_node(7, 0)
      
      @minimax.minimax.should == [winning_move, tie_move]      
    end
    
    it "returns moves when there are losing and tie moves" do
      mark([2, 3, 4], @player_value)
      mark([0, 5, 6, 7], @opponent_value)
      losing_move = move_node(1, -1)
      tie_move = move_node(8, 0)
      @minimax.minimax.should == [losing_move, tie_move]
    end 
  end
  
  context "when there are three moves left" do
    it "chooses the winning move when there is one available" do
      mark([1, 4], @player_value)
      mark([0, 3, 2, 5], @opponent_value)
      @minimax.move.should == 7
    end

    it "chooses a tie move when there are only losing and tie moves" do
      mark([1, 3, 5], @player_value)
      mark([0, 2, 4], @opponent_value)
      @minimax.move.should == 6
    end
  end
  
  context "when there are 4 moves left" do
    it "chooses a winning move when one is available" do
      mark([4, 8], @player_value)
      mark([1, 2, 6], @opponent_value)
      @minimax.move.should == 0
    end
    
    it "chooses a move that would create 2 winning moves" do
      mark([0, 6], @player_value)
      mark([1, 3, 5], @opponent_value)
      @minimax.move.should == 4
    end
    
  end
  
  
  
  def move_node(move, score)
    TicTacToe::Move.new(move, score)
  end
  
  def mark(squares, value)
    squares.each {|i| @board.mark(i, value)}
  end
end