require 'tic_tac_toe/rules'
require 'tic_tac_toe/ui/console'
require 'tic_tac_toe/game_state_factory'
require 'tic_tac_toe/board'

module TicTacToe
  class Game
    attr_writer :rules

    def initialize(ui = TicTacToe::Console.new, game_state_factory = TicTacToe::GameStateFactory.new)
      @ui = ui
      @game_state_factory = game_state_factory
    end

    def start
      ui.display_welcome_message
      @game_state = create_game_state
      play until rules.game_over?
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
      player = game_state.current_player
      ui.display_player_turn(player)
      make_move(player)
      game_state.change_player
    end

    def make_move(player)
      begin
        player.move(board)
      rescue MoveNotAvailableError
        make_move
      end
    end

    def display_result
      player = game_state.player(rules.winner)
      if player
        ui.display_winner(player)
      else
        ui.display_tied_game
      end
    end

    def board
      game_state.board
    end

    def rules
      @rules ||= TicTacToe::Rules.new(board)
    end
  end
end
