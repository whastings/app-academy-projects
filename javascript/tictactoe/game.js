"use strict";

(function(root) {

  var TicTacToe = root.TicTacToe = (root.TicTacToe || {});

  var Game = TicTacToe.Game = function(player1, player2, board) {
    this.board = board;
    this.currentPlayer = player1;
    this.player1 = player1;
    this.player2 = player2;
  };

  Game.prototype.play = function() {
    var that = this;
    this.display();
    this.currentPlayer.userInput(function(pos) {
      if (that.board.valid(pos)) {
        that.board.placeMark(pos, that.currentPlayer.mark);
        if (that.board.won(that.currentPlayer.mark)) {
          console.log(that.currentPlayer.name + ' wins!');
          that.display();
          return;
        }
        that.switchPlayers();
      } else {
        console.log('Invalid move.');
      }
      that.play();
    });
  };

  Game.prototype.switchPlayers = function() {
    this.currentPlayer = (this.currentPlayer === this.player1) ?
      this.player2 : this.player1;
  };

  Game.prototype.display = function() {
    this.board.grid.forEach(function(row) {
      process.stdout.write('| ');
      row.forEach(function(col) {
        var space = col || " ";
        process.stdout.write(space + " | ");
      });
      process.stdout.write('\n-------------\n');
    });
    process.stdout.write('\n');
  };

})(global);
