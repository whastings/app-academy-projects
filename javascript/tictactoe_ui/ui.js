(function(root) {
  "use strict";

  var TTT = root.TTT = (root.TTT || {});
  var UI = TTT.UI = function(game) {
    this.newGrid();
    this.addClickHandlers();
    this.game = game;
    this.updateTurnText();
  };


  UI.prototype.newGrid = function() {
    var $outerDiv = $('<div></div>');
    $outerDiv.addClass('container');
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j< 3 ; j++) {
        var $innerDiv = $('<div></div>');
        $innerDiv.addClass('cell');
        $innerDiv.attr("data-row", i);
        $innerDiv.attr("data-col", j);
        $outerDiv.append($innerDiv);
      }
    }
    $("body").append($outerDiv);
    this.$turnText = $('<div></div>');
    this.$turnText.addClass('turn-text').appendTo($('body'));
    this.$outerDiv = $outerDiv;
  };

  UI.prototype.addClickHandlers = function() {
    this.$outerDiv.on('click', '.cell', this.handleCellClick.bind(this));
  };

  UI.prototype.removeClickHandlers = function() {
    this.$outerDiv.off('click');
  };

  UI.prototype.handleCellClick = function(event) {
    var $target = $(event.currentTarget);
    var row = $target.data("row");
    var col = $target.data("col");
    var move = this.game.move([row,col])
    if (move) {
      $target.html("<div class='letter " + move + "' >" + move + "</div>");
      this.updateTurnText();
      var winner = this.game.winner();
      if (winner) {
        this.removeClickHandlers();
        alert(winner + ' is the winner!');
      }
    } else {
      alert("Can't move there!");
    };
  };

  UI.prototype.updateTurnText = function() {
    this.$turnText.html('Current player is ' + this.game.player);
  };

})(this);