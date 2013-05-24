module TicTacToe
  class ComputerPlayer
    attr_reader :name, :value
    
    def initialize(options)
      @name = options[:name]
      @value = options[:value]
      @output = options[:output] || STDOUT
      @player = options[:player]
      @opponent = options[:opponent]
      @board = options[:board]
      @rules = options[:rules]
    end
    
    def move
      @output.puts("Computer is calculating a move, please wait.")
      # start = Time.now
      @current_player = @player
      moves = minimax 
      # sorted_moves = moves.sort{ |a, b| [a.score, a.depth] <=> [b.score, b.depth]}
      max_move(moves).move
    end
    
    # private
    WINNING_SCORE = 1
    LOSING_SCORE = -1
    TIE = 0
    
    def minimax
      moves = []
      available_moves = @board.available_squares
      available_moves.each do |move|
        @board.mark(move, @current_player)
        if score
          moves << Move.new(move, score, 0)
        else
          child_move = best_child_move
          moves << Move.new(move, child_move.score, child_move.depth += 1)
        end
        
        # move_score = score || best_child_score
        # moves << Move.new(move, move_score)
        @board.clear(move)
        # break if found_best_move?(move_score)
      end
      moves
    end 
    
    def best_child_move
      change_current_player
                  
      children_moves = minimax
      
      player_best_move = player_turn?? max_move(children_moves) : min_move(children_moves) #what type of move?
      
      change_current_player
      
      player_best_move
    end
        
    def player_turn?
      @current_player == @player
    end
    
    def change_current_player
      @current_player = (@current_player == @player) ? @opponent : @player
    end
    
    def found_best_move?(move_score)
      if player_turn?
        return true if move_score == WINNING_SCORE
      else
        return true if move_score == LOSING_SCORE
      end
      false
    end
    
    def score
      return WINNING_SCORE if @rules.win?(@player)
      return LOSING_SCORE if @rules.win?(@opponent)
      return TIE if @rules.tied?(@player)
      nil    
    end

    def max_move(moves)
      sorted_moves = moves.sort{ |a, b| [a.score, a.depth] <=> [b.score, b.depth]}
      # max_move(sorted_moves).move
      
      sorted_moves.max_by {|m| m.score}
    end
    
    def min_move(moves)
      sorted_moves = moves.sort{ |a, b| [a.score, a.depth] <=> [b.score, b.depth]}
      
      moves.min_by {|m| m.score}
      # sorted_moves[-1]
    end
    
    def winning_move(moves)
      moves.detect {|m| m.score == WINNING_SCORE}
    end    
  end
  
  Move = Struct.new(:move, :score, :depth)
end
