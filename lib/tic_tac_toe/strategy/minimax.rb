require 'tic_tac_toe/rules'

module TicTacToe
  module Strategy
    class Minimax
      def initialize(board, player, opponent)
        @board = board
        @player = player
        @opponent = opponent
      end

      def move
        return first_move if first_move?
        move = minimax(@player, @board)
        move.move
      end

      private
      WINNING_SCORE = 1
      LOSING_SCORE = -1
      TIE = 0
      MIDDLE_SQUARE = 4

      def first_move?
        moves_count = @board.number_of_moves
        moves_count == 0 || moves_count == 1
      end

      def first_move
        return MIDDLE_SQUARE if @board.available_moves.include?(MIDDLE_SQUARE)
        0
      end

      def minimax(player, board)
        moves = []
        board.available_moves.each do |move|
          clone_board = board.clone
          clone_board.mark(move, player)
          moves << player_move(player, move, clone_board)
          found_best_move?(moves[-1])
        end
        best_move(moves)
      end

      def player_move(player, move, board)
        if rules(board).game_over?
          PlayerMove.new(move, score(player, board), 0)
        else
          child_move = minimax(opponent(player), board)
          PlayerMove.new(move, -child_move.score, child_move.depth += 1)
        end
      end

      def found_best_move?(move)
        move.score == WINNING_SCORE and move.depth == 0
      end

      def score(player, board)
        winner = rules(board).winner
        return WINNING_SCORE if winner == player
        return LOSING_SCORE if winner == opponent(player)
        return TIE if rules(board).tied?
      end

      def opponent(player)
        (player == @player) ? @opponent : @player
      end

      def best_move(moves)
        sorted_moves = moves.sort{ |a, b| [a.score, a.depth] <=> [b.score, b.depth]}
        sorted_moves.max_by {|m| m.score}
      end

      def rules(board)
        TicTacToe::Rules.new(board)
      end
    end

    PlayerMove = Struct.new(:move, :score, :depth)
  end
end
