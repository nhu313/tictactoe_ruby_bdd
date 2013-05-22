require 'tictactoe/rules'
module TicTacToe
  class MinimaxStrategy
    
    def initialize(player_value, opponent_value, board)
      @current_player = @player_value = player_value
      @opponent_value = opponent_value
      @board = board
      @rules = TicTacToe::Rules.new(@board)
    end
    
    def move
      puts("Computer is calculating a move, please wait.")
      # start = Time.now
      @current_player = @player_value
      moves = minimax
      move = winning_move(moves) || max_move(moves)
      # puts("total #{Time.now - start}")
      move.move
    end
    
    def winning_move(moves)
      moves.detect {|m| m.score == 1}
    end
    
    def minimax
      moves = []
      available_moves = @board.available_squares
      available_moves.each do |move|
        @board.mark(move, @current_player)
        move_score = score || best_child_score
        moves << Move.new(move, move_score)
        @board.mark(move, move)
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
      @current_player == @player_value
    end
    
    def change_current_player
      @current_player = (@current_player == @player_value) ? @opponent_value : @player_value
    end
    
    def score
      return 1 if @rules.win?(@player_value)
      return -1 if @rules.win?(@opponent_value)
      return 0 if @rules.tied?(@player_value)
      nil    
    end

    def max_move(moves)
      moves.max_by {|m| m.score}
    end
    
    def min_move(moves)
      moves.min_by {|m| m.score}
    end
  end
  
  Move = Struct.new(:move, :score)  
end