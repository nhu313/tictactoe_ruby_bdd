#Overview#
This is a Tic Tac Toe game written in Ruby. See [wikipedia](http://en.wikipedia.org/wiki/Tic-tac-toe) for more information on the game. It uses the console for the UI.

Before you run any test or start the game, make sure you do "bundle install" to retrieve all the required gems.

#Start game#
rake play

#Test#
The test files live in spec/tic_tac_toe.

To run all the test:
'rake'

To run the slow test (i.e. computer player):
rake slow_test

To run all the test except the slow test:
rake test
