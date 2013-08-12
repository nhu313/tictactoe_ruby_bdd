require 'tic_tac_toe/ui/console'
require 'tic_tac_toe/game_factory'
require 'tic_tac_toe/board'

module TicTacToe
  class Runner

    def initialize(ui = TicTacToe::Console.new, game_state_factory = TicTacToe::GameFactory.new)
      @ui = ui
      @game_state_factory = game_state_factory
    end

    def start
      ui.display_welcome_message
      @game_state = create_game_state
      play until game_state.game_over?
      ui.display_board(board)
      display_result
    end

    private
    attr_reader :ui, :game_state, :game_state_factory

    def create_game_state
      game_type = ui.game_type
      begin
        game_state_factory.create(game_type)
      rescue ArgumentError
        create_game_state
      end
    end

    def play
      ui.display_board(board)
      ui.display_player_turn(game_state.current_player)
      make_player_move
    end

    def make_player_move
      begin
        game_state.make_player_move
      rescue MoveNotAvailableError
        make_player_move
      end
    end

    def display_result
      winner = game_state.winner
      if winner
        ui.display_winner(winner)
      else
        ui.display_tied_game
      end
    end

    def board
      game_state.board
    end
  end
end
