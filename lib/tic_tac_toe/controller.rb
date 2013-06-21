require 'tic_tac_toe/rules'
require 'tic_tac_toe/ui/console'
require 'tic_tac_toe/game_factory'
require 'tic_tac_toe/board'

module TicTacToe
  class Controller

    def initialize(ui = TicTacToe::Console.new, game_factory = TicTacToe::GameFactory.new)
      @ui = ui
      @board = TicTacToe::Board.new
      @rules = TicTacToe::Rules.new(@board)
      @game_factory = game_factory
    end

    def start
      @ui.display_welcome_message
      game_type = @ui.game_type
      @game = game_factory.create(game_type, @board)

      play
      @ui.display_board(@board)
      @ui.display(@game.result_msg(@rules.winner))
    end

    private
    attr_reader :game_factory

    def play
      @ui.display_board(@board)
      player = @game.current_player
      @ui.display("It's #{player.name}(#{player.value}) turn.")
      begin
        @game.move
      rescue MoveNotAvailableError
        @ui.display("Square is not available. Please enter a different square.")
      end
      play until @rules.game_over?
    end

  end
end
