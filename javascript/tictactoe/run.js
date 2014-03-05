require('./board');
require('./game');
require('./humanplayer');
require('./computerplayer');

var TicTacToe = global.TicTacToe;

var run = function() {
  var board = new TicTacToe.Board();
  var humanPlayer = new TicTacToe.HumanPlayer('Joe', 'x');
  var computerPlayer = new TicTacToe.ComputerPlayer('Tron', 'o', board);
  var game = new TicTacToe.Game(humanPlayer, computerPlayer, board);
  game.play();
};

run();