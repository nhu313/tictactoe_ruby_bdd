require 'tictactoe/game'
require 'tictactoe/player/human_player'

describe TicTacToe::Game do  
  before(:each) do
    @board = mock().as_null_object    
    @ui = mock().as_null_object
    # @ui.should_receive(:play_again?).and_return(false)
    
    @rules = mock().as_null_object
    @game = TicTacToe::Game.new(@board, @ui, @rules)
    @player = mock().as_null_object    
    @game.player2 = @game.player1 = @player
  end
  
  describe "start game" do    
    it "display welcome message" do
      @ui.should_receive(:display_welcome_message)
      @game.start
    end    
  end
  
  describe "play game" do    
    it "display board" do
      @ui.should_receive(:display_board)
      @game.start
    end
    
    it "prompt for move" do
      @player.should_receive(:move)
      @game.start
    end
    
    it "mark the board with user input" do
      move = 7
      @player.should_receive(:move).and_return(move)
      @board.should_receive("mark").with(move, @player)
      @game.start
    end
    
    it "asks for user move again if the player did not win" do
      @player.should_receive(:move).exactly(2)
      @rules.should_receive(:game_over?).and_return(false, true)
      @game.start
    end    
  end
  
  describe "end game" do
    it "displays the board when the game is over" do
      @ui.should_receive(:display_board).at_least(2)
      @game.start
    end
    
    it "notifies user when player wins" do
      winner_name = "winner"
      winner = mock().as_null_object()
      winner.should_receive(:name).and_return(winner_name)
      
      @rules.should_receive(:game_over?).and_return(true)
      @rules.should_receive(:winner).and_return(winner)
      @ui.should_receive(:display_winner).with(winner_name)
      @game.start      
    end
    
    it "notifies user when it's a tied game" do
      @rules.should_receive(:game_over?).and_return(true)
      @rules.should_receive(:winner).and_return(nil)
      @ui.should_receive(:display_tied_game)
      @game.start
    end
  end
  
  # describe "change player after a move" do
  #   xit "changes to player 2 after player 1 moves" do
  #     player2 = TicTacToe::Player.new("player2", "O", nil)
  #     @game.player2 = player2
  #     
  #     @rules.should_receive(:win?).exactly(3).times.with("X", "O", "O").and_return(false, true, true)
  #     @rules.should_receive(:win?).exactly(1).times.with(player2.value).and_return(true)      
  #     board.should_receive(:filled?).at_least(:once).and_return(false)
  #     @game.start
  #   end
  #   
  # end
  
  # describe "play again" do
  #   xit "reset the board when user wants to play again" do
  #     @board.should_receive(:reset)
  #     @ui.should_receive(:play_again?).and_return(true, false)
  #     game.start
  #   end
  # end
end