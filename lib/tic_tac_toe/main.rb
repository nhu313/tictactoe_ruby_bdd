require 'tic_tac_toe/ui/console'
require 'tic_tac_toe/game_factory'
require 'tic_tac_toe/board'

module TicTacToe
  class Main
    attr_writer :rules

    def initialize(ui = TicTacToe::Console.new, game_factory = TicTacToe::GameFactory.new)
      @ui = ui
      @board = TicTacToe::Board.new
      @game_factory = game_factory
    end

    def start
      @ui.display_welcome_message
      game_type = @ui.game_type
      @game = @game_factory.create(game_type, @board)

      play until @game.over?
      @ui.display_board(@board)
      display_result
    end

    private
    def play
      @ui.display_board(@board)
      player = @game.current_player
      @ui.display_player_turn(player)
      begin
        @game.make_move
      rescue MoveNotAvailableError
        @ui.display_square_not_available
      end
    end

    def display_result
      winner = @game.winner
      if winner
        @ui.display_winner(winner)
      else
        @ui.display_tied_game
      end
    end

  end
end
