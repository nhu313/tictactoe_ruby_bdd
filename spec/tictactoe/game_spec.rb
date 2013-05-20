require 'tictactoe/game'
require 'tictactoe/player/player'

describe TicTacToe::Game do
  attr_reader :game, :board, :ui, :win_determiner, :player
  
  before(:each) do
    @board = mock().as_null_object
    
    @ui = mock().as_null_object
    # @ui.should_receive(:play_again?).and_return(false)
    
    @win_determiner = mock().as_null_object
    
    @game = TicTacToe::Game.new(@board, @ui, @win_determiner)
    
    @player_strategy = mock().as_null_object
    @player = TicTacToe::Player.new("player1", "X", @player_strategy)
    
    @game.player2 = @game.player1 = @player
  end
  
  describe "start game" do    
    it "display welcome message" do
      ui.should_receive(:display_welcome_message)
      game.start
    end    
  end
  
  describe "play game" do
    
    it "display board" do
      ui.should_receive(:display_board)
      game.start
    end
    
    it "prompt for move" do
      @player.should_receive(:move)
      game.start
    end
    
    it "mark the board with user input" do
      move = 7
      @player.should_receive(:move).and_return(move)
      board.should_receive("mark").with(move, player.value)
      game.start
    end
    
    it "asks for user move again if the player did not win" do
      @player.should_receive(:move).exactly(2)
      win_determiner.should_receive(:tied?).at_least(1).times.and_return(false)
      win_determiner.should_receive(:win?).with(player.value).and_return(false, true)
      game.start
    end
    
    it "asks for user move again if user did not win and the board is not filled" do
      @player.should_receive(:move).exactly(2)
      win_determiner.should_receive(:win?).at_least(:once).with(player.value).and_return(false)
      win_determiner.should_receive(:tied?).at_least(1).times.and_return(false, true)
      game.start
    end 
  end
  
  describe "end game" do
    it "displays the board when the game is over" do
      ui.should_receive(:display_board).at_least(2)
      game.start
    end
    
    it "notifies user when player wins" do
      win_determiner.should_receive(:win?).with(player.value).and_return(true)
      ui.should_receive(:display_winner).with("player1")
      game.start      
    end
    
    it "notifies user when it's a tied game" do
      win_determiner.should_receive(:win?).at_least(2).times.with(player.value).and_return(false)
      win_determiner.should_receive(:tied?).at_least(1).times.and_return(true)
      ui.should_receive(:display_tied_game)
      game.start
    end
  end
  
  describe "change player after a move" do
    xit "changes to player 2 after player 1 moves" do
      player2 = TicTacToe::Player.new("player2", "O", nil)
      @game.player2 = player2
      
      @win_determiner.should_receive(:win?).exactly(3).times.with("X", "O", "O").and_return(false, true, true)
      win_determiner.should_receive(:win?).exactly(1).times.with(player2.value).and_return(true)      
      board.should_receive(:filled?).at_least(:once).and_return(false)
      game.start
    end
    
  end
  
  describe "play again" do
    xit "reset the board when user wants to play again" do
      @board.should_receive(:reset)
      @ui.should_receive(:play_again?).and_return(true, false)
      game.start
    end
  end
end