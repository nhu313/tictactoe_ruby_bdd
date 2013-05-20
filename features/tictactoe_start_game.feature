Feature: Tic Tac Toe starts game
  As a player
  I want to start a game
  So I can start to make my move
  
  Scenario: start game
    Given I am not yet playing
    When I start a new game
    Then I should see "Welcome to Tic Tac Toe!"
    And I should see the board
    And I should see "Please choose a move:"