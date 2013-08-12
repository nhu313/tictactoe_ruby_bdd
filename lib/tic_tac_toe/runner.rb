require 'tic_tac_toe/ui/console'
require 'tic_tac_toe/game_factory'
require 'tic_tac_toe/board'

module TicTacToe
  class Runner

    def initialize(ui = TicTacToe::Console.new, game_factory = TicTacToe::GameFactory.new)
      @ui = ui
      @game_factory = game_factory
    end

    def start
      ui.display_welcome_message
      @game = create_game
      play until game.over?
      ui.display_board(board)
      display_result
    end

    private
    attr_reader :ui, :game, :game_factory

    def create_game
      game_type = ui.game_type
      begin
        game_factory.create(game_type)
      rescue ArgumentError
        create_game
      end
    end

    def play
      ui.display_board(board)
      ui.display_player_turn(game.current_player)
      make_player_move
    end

    def make_player_move
      begin
        game.make_player_move
      rescue MoveNotAvailableError
        make_player_move
      end
    end

    def display_result
      winner = game.winner
      if winner
        ui.display_winner(winner)
      else
        ui.display_tied_game
      end
    end

    def board
      game.board
    end
  end
end
