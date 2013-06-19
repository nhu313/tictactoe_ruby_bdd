require 'tic_tac_toe/rules'

module TicTacToe
  module Strategy
    class Minimax
      def initialize(board, player, opponent, output = STDOUT)
        @board = board
        @player = player
        @opponent = opponent
        @rules = TicTacToe::Rules.new(@board)
        @output = output
      end

      def move
        @output.puts("Computer is calculating a move. Please wait.")
        if first_move?
          first_move
        else
          move = minimax(@player)
          move.move
        end
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

      def minimax(player)
        moves = []
        @board.available_moves.each do |move|
          @board.mark(move, player)
          moves << player_move(player, move)
          @board.clear(move)
          found_best_move?(moves[-1])
        end
        best_move(moves)
      end

      def player_move(player, move)
        if @rules.game_over?
          PlayerMove.new(move, score(player), 0)
        else
          child_move = minimax(opponent(player))
          PlayerMove.new(move, -child_move.score, child_move.depth += 1)
        end
      end

      def found_best_move?(move)
        move.score == WINNING_SCORE and move.depth == 0
      end

      def score(player)
        winner = @rules.winner
        return WINNING_SCORE if winner == player
        return LOSING_SCORE if winner == opponent(player)
        return TIE if @rules.tied?

        nil
      end

      def opponent(player)
        (player == @player) ? @opponent : @player
      end

      def best_move(moves)
        sorted_moves = moves.sort{ |a, b| [a.score, a.depth] <=> [b.score, b.depth]}
        sorted_moves.max_by {|m| m.score}
      end
    end

    PlayerMove = Struct.new(:move, :score, :depth)
  end
end
