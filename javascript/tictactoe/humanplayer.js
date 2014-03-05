"use strict";

var readline = require('readline');

(function(root) {

  var getReader = function() {
    return readline.createInterface({
      input: process.stdin,
      output: process.stdout
    });
  };

  var TicTacToe = root.TicTacToe = (root.TicTacToe || {});

  var HumanPlayer = TicTacToe.HumanPlayer = function(name, mark) {
    this.name = name;
    this.mark = mark;
  };

  HumanPlayer.prototype.userInput = function(callback) {
    var reader = getReader();
    reader.question('Which row would you like to place your mark?\n', function(y) {
      reader.question('Which column would you like to place your mark?\n', function(x) {
        reader.close();
        callback([y, x]);
      });
    });
  };

})(global);
