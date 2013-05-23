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
      move = winning_move(moves) || max_move(moves)
      # puts("total #{Time.now - start}")
      move.move
    end
    
    private
    def minimax
      moves = []
      available_moves = @board.available_squares
      available_moves.each do |move|
        @board.mark(move, @current_player)
        move_score = score || best_child_score
        moves << Move.new(move, move_score)
        @board.clear(move)
        break if found_best_move?(move_score)
      end
      moves
    end
    
    def best_child_score
      change_current_player
                  
      children_moves = minimax
      player_best_move = player_turn?? max_move(children_moves) : min_move(children_moves) #what type of move?
      
      change_current_player      
      player_best_move.score
    end
    
    def player_turn?
      @current_player == @player
    end
    
    def change_current_player
      @current_player = (@current_player == @player) ? @opponent : @player
    end
    
    def found_best_move?(move_score)
      if player_turn?
        return true if move_score == 1
      else
        return true if move_score == -1
      end
      false
    end
    
    def score
      return 1 if @rules.win?(@player)
      return -1 if @rules.win?(@opponent)
      return 0 if @rules.tied?(@player)
      nil    
    end

    def max_move(moves)
      moves.max_by {|m| m.score}
    end
    
    def min_move(moves)
      moves.min_by {|m| m.score}
    end
    
    # private

    WINNING_SCORE = 1
    LOSING_SCORE = -1
    TIE = 0
    
    
    def winning_move(moves)
      moves.detect {|m| m.score == WINNING_SCORE}
    end
    
  end
  
  Move = Struct.new(:move, :score)
end