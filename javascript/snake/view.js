(function(root) {

  var Snakes = root.Snakes = (root.Snakes || {});

  var View = Snakes.View = function(el) {
    this.$el = el;
  };

  View.prototype.start = function() {
    this.board = new Snakes.Board(25, 25);
    this.snake = this.board.snake;
    $(document).on('keydown', this.handleKeyEvent.bind(this));
    this.interval = setInterval(this.step.bind(this), 150);
    this.turnNum = 0;
  };

  View.prototype.handleKeyEvent = function(event) {
    switch (event.keyCode) {
    case 38:
      this.snake.turn('N');
      break;
    case 39:
      this.snake.turn('E');
      break;
    case 40:
      this.snake.turn('S');
      break;
    case 37:
      this.snake.turn('W');
      break;
    }
  };

  View.prototype.step = function(){
    var newSegment = this.board.move();
    if (this.board.outOfBoundsCoord(newSegment) || this.snake.collided()) {
      alert('Game over! \n Your Score: '+ this.board.applesEaten * 10 );
      this.stop();
    }
    else {
      this.turnNum++;
      if (this.turnNum % 10 === 0) {
        this.snake.shrink();
      }
      if (this.turnNum % 20 === 0) {
        this.snake.increaseBaseSize();
        this.board.addApple();
      }
      var $newEl = this.board.renderHTML();
      this.$el.replaceWith($newEl);
      this.$el = $newEl;
    }
  }



  View.prototype.stop = function() {
    clearInterval(this.interval);
    $(document).off('keydown');
  };

})(this);