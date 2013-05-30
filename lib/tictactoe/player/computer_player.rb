module TicTacToe
  class ComputerPlayer
    attr_reader :name, :value
    
    def initialize(options)
      @name = options[:name]
      @value = options[:value]
      @output = options[:output] || STDOUT
      @computer = options[:player]
      @opponent = options[:opponent]
      @board = options[:board]
      @rules = options[:rules]
    end
    
    def move
      @output.puts("Computer is calculating a move, please wait.")
      # start = Time.now
      move = minimax(@computer)
      move.move
    end
    
    # private
    WINNING_SCORE = 1
    LOSING_SCORE = -1
    TIE = 0

    def minimax(player)
      moves = []
      available_moves = @board.available_squares
      available_moves.each do |move|
        @board.mark(move, player)
        if score(player)
          moves << Move.new(move, score(player), 0)
        else          
          child_move = minimax(opponent(player))
          moves << Move.new(move, -child_move.score, child_move.depth += 1)
        end
        @board.clear(move)
        break if found_best_move?(moves[-1])
      end
      max_move(moves)
    end 
    
    def found_best_move?(move)
      move.score == WINNING_SCORE and move.depth == 0
    end

    def score(player)
      return WINNING_SCORE if @rules.win?(player)
      return LOSING_SCORE if @rules.win?(opponent(player))
      return TIE if @rules.tied?(player)
      return TIE if @rules.tied?(opponent(player))
      
      nil    
    end
    
    def opponent(player)
      (player == @computer) ? @opponent : @computer
    end

    def max_move(moves)
      sorted_moves = moves.sort{ |a, b| [a.score, a.depth] <=> [b.score, b.depth]}
      sorted_moves.max_by {|m| m.score}
    end
    
    def winning_move(moves)
      moves.detect {|m| m.score == WINNING_SCORE}
    end    
  end
  
  Move = Struct.new(:move, :score, :depth)
end
