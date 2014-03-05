"use strict";

(function(root) {

  var TicTacToe = root.TicTacToe = (root.TicTacToe || {});

  var ComputerPlayer = TicTacToe.ComputerPlayer = function(name, mark, board) {
    this.board = board;
    this.name = name;
    this.mark = mark;
  };

  ComputerPlayer.prototype.userInput = function(callback) {
    var choice = this.findMove();
    if (!choice) {
      choice = this.randomMove();
    }
    callback(choice);
  };

  ComputerPlayer.prototype.randomMove = function() {
    var choice = false;
    while (!choice) {
      var randomNumbers = [];
      for( var i = 0; i < 2; i++) {
        randomNumbers.push(Math.floor((Math.random()*2)));
      }
      if (this.board.valid(randomNumbers)) {
        choice = randomNumbers;
      }
    }
    return choice;
  };

  ComputerPlayer.prototype.winningMove = function(pos) {
    var duppedBoard = this.board.dup();
    duppedBoard.placeMark(pos, this.mark);
    return duppedBoard.won(this.mark);
  };

  ComputerPlayer.prototype.findMove = function() {
    var choice;
    var that = this;
    this.board.grid.forEach( function(row, i) {
      row.forEach( function(col, j) {
        var pos = [i, j];
        if (that.board.valid(pos) && that.winningMove(pos)) {
          choice = pos;
          return false;
        }
      });
      if (choice) {
        return false;
      }
    });
    return choice;
  };

})(global);
