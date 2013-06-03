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
      # start if @ui.play_again?
    end
    
    private    
    def play
      change_player
      @ui.display_board
      move = @current_player.move
      @board.mark(move, @current_player)
      play until @rules.game_over?
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