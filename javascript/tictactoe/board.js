"use strict";

(function(root) {

  var TicTacToe = root.TicTacToe = (root.TicTacToe || {});

  var Board = TicTacToe.Board = function() {
    this.grid = [];
    for (var i = 0; i < 3; i++) {
      this.grid[i] = [];
      for (var j = 0; j < 3; j++) {
        this.grid[i].push(null);
      }
    }
  };

  Board.prototype.placeMark = function(pos, mark) {
    this.grid[pos[0]][pos[1]] = mark;
  };

  Board.prototype.valid = function(pos) {
    var y = pos[0];
    var x = pos[1];
    return (x >= 0 && x <= 2 && y >= 0 && y <= 2 && !(this.grid[y][x]));
  };

  Board.prototype.won = function(mark) {
    return (this.verticalWin(mark) || this.horizontalWin(mark) || this.diagonalWin(mark));
  };

  Board.prototype.horizontalWin = function(mark) {
    var horizWinner = false;
    this.grid.some(function(row) {
      var hw = row.every(function(space) {
        return space === mark;
      });
      if (hw) {
        horizWinner = true;
        return true;
      }
    });
    return horizWinner;
  };

  Board.prototype.transpose = function(arr) {
    var transposed = [];
    var length = arr.length;
    for (var i = 0; i < length; i++) {
      for (var j = 0; j < length; j++) {
        if (i === 0) {
          transposed.push(new Array(3));
        }
        transposed[j][i] = arr[i][j];
      }
    }
    return transposed;
  };

  Board.prototype.getPos = function(pos) {
    var y = pos[0], x = pos[1];
    return this.grid[y][x];
  };

  var CORNERS = [[[0,0],[2,2]], [[2,0], [0,2]]];

  Board.prototype.verticalWin = function(mark) {
    var transposed = this.transpose(this.grid);
    return this.horizontalWin.call({grid:transposed}, mark);
  };

  Board.prototype.diagonalWin = function(mark) {
    if (this.grid[1][1] !== mark) {
      return false;
    }
    var that = this;
    var diagWinner = false;
    CORNERS.some( function(el) {
      var dw = (that.getPos(el[0]) === mark && that.getPos(el[1]) === mark);
      if (dw) {
        diagWinner = true;
        return true;
      }
    });
    return diagWinner;
  };

  Board.prototype.dup = function() {
    var duppedBoard = new Board();
    this.grid.forEach( function(row, i) {
      row.forEach( function(col, j) {
        duppedBoard.grid[i][j] = col;
      });
    });
    return duppedBoard;
  };

})(global);
