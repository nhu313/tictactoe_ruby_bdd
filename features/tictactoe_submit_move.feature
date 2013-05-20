Feature: player submits a move
  As a player
  I want to submit a move
  So I can win the game
  
  Scenario: submit move
    Given I start playing the game
    When I enter a number to make a move
    Then I should see my mark on the board
