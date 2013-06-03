require 'tictactoe/board'

module TicTacToe
  class Game
    
    attr_writer :player1, :player2
    
    def initialize(board, ui, rules)
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
      move
      play until @rules.game_over?
    end
    
    def move
      player_move = @current_player.move
      begin
        @board.mark(player_move, @current_player)
      rescue MoveNotAvailableError
        move
      end      
    end
    
    def change_player
      @current_player = (@current_player == @player1) ? @player2 : @player1      
    end
    
    def result
      winner = @rules.winner
      if winner 
        @ui.display_winner(winner.name) 
      else
        @ui.display_tied_game 
      end
    end

  end
end