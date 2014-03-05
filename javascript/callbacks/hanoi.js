/* Pair programming partner: Shah Rukh Paracha */

"use strict";

(function (root) {

  var Hanoi = root.Hanoi = (root.Hanoi || {});

  var readline = require('readline');

  var READER = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  var Game = Hanoi.Game = function(numDisks, numStacks) {
    this.numDisks = numDisks;
    this.numStacks = numStacks;
    this.stacks = [];
    for (var i = 0; i < numStacks; i++) {
      this.stacks.push([]);
    }
    for (i = 0; i < numDisks; i++) {
      this.stacks[0].unshift(i + 1);
    }
  };

  Game.prototype.playTurn = function(callback) {
    var that = this;
    this.playerInput( function(startStack, endStack){
      var valid = that._validMove(startStack, endStack);
      if (valid) {
        that.moveDisk(startStack, endStack);
        console.log(that.stacks);
      } else {
        console.log('Invalid move.');
      }
      callback();
    });
  };

  Game.prototype.moveDisk = function(startStack, endStack) {
    var disk = this.stacks[startStack].pop();
    this.stacks[endStack].push(disk);
  };

  Game.prototype._validMove = function(startStack, endStack) {
    var startDisk = this.stacks[startStack].slice(-1).pop();
    var endDisk = this.stacks[endStack].slice(-1).pop();
    return (startDisk && (!endDisk || startDisk < endDisk));
  };

  Game.prototype.playerInput = function(callback) {
    READER.question("Which stack would you like to get from?", function(startStack) {
      READER.question("Which stack would you like to move to?", function(endStack) {
        startStack = +startStack;
        endStack = +endStack;
        callback(startStack, endStack);
      });
    });
  };

  Game.prototype.won = function() {
    var lastStack = this.stacks.slice(-1).pop();
    return (lastStack.length === this.numDisks);
  };

  Game.prototype.playGame = function() {
    if (this.won()) {
      console.log('Congrats. You won!');
      READER.close();
      return;
    }
    this.playTurn(this.playGame.bind(this));
  };

})(this);

var game = new this.Hanoi.Game(4, 4);
game.playGame();
