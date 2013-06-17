require 'tic_tac_toe/rules'

module TicTacToe
  class Game

    attr_writer :player1, :player2

    def initialize(board, ui, rules=TicTacToe::Rules.new(board))
      @board = board
      @ui = ui
      @rules = rules
    end

    def start
      @ui.display_welcome_message
      play
      @ui.display_board
      result
    end

    private
    def play
      @ui.display_board
      change_player
      make_move
      play until @rules.game_over?
    end

    def make_move
      player_move = @current_player.move
      begin
        @board.mark(player_move, @current_player.value)
      rescue MoveNotAvailableError
        make_move
      end
    end

    def change_player
      @current_player = (@current_player == @player1) ? @player2 : @player1
    end

    def result
      player = winner(@rules.winner)
      if player
        @ui.display_winner(player.name)
      else
        @ui.display_tied_game
      end
    end

    def winner(winner_value)
      return nil if !winner_value
      return @player1 if winner_value == @player1.value
      @player2
    end

  end
end
