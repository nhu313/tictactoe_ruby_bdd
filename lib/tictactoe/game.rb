module TicTacToe
  class Game
    
    attr_writer :player1, :player2
    
    def initialize(board, ui, win_determiner)
      @board = board
      @ui = ui
      @win_determiner = win_determiner
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
      @board.mark(move, @current_player.to_sym)
      play until over?
    end
    
    def change_player
      @current_player = (@current_player == @player1) ? @player2 : @player1      
    end
    
    def over?
      return true if @win_determiner.win?(@current_player.to_sym)
      return true if @win_determiner.tied?(@current_player.to_sym)
      false
    end
    
    def result
      if @win_determiner.win?(@current_player.to_sym) 
        @ui.display_winner(@current_player.name) 
      else
        @ui.display_tied_game 
      end
    end

  end
end