(function(root){
  var Snakes = root.Snakes = (root.Snakes || {})
  var Board = Snakes.Board = function(height, width){
    this.height = height;
    this.width  = width;
    this.snake = new Snakes.Snake();
    this.apples = [];
    this.applesEaten = 0;
  };

  Board.prototype.render = function(){
    var array = this.boardArray(function() {
      return '.';
    });
    this.snake.segments.forEach(function(segment) {
      array[segment.row][segment.col] = 'S';
    });
    for (i = 0, l = array.length; i < l; i++) {
      array[i] = array[i].join(' ');
    }
    return array.join('\n');
  };

  Board.prototype.renderHTML = function() {
    var array = this.boardArray(function() {
      return $('<div class="cell"></div>');
    });
    this.snake.segments.forEach(function(segment) {
      array[segment.row][segment.col].addClass('snake');
    });
    this.apples.forEach(function(apple) {
      array[apple.row][apple.col].addClass('apple');
    });
    var $container = $("<div class='container'></div>");
    for (var i = 0; i < this.height ; i++ ){
      var $row = $("<div class='row'></div>");
      for (var j=0 ; j < this.width ; j++ ){
        $row.append(array[i][j]);
      }
      $container.append($row);
    }
    return $container;
  };

  Board.prototype.boardArray = function(callback) {
    var array = [];
    for (var i = 0; i < this.height ; i++){
      array.push([]);
      for (var j = 0; j < this.width ; j++){
        array[i][j] = callback();
      }
    }
    return array;
  };

  Board.prototype.outOfBoundsCoord = function(coord) {
    return (coord.row < 0 || coord.col < 0 ||
        coord.row >= this.height || coord.col >= this.width);
  };

  Board.prototype.addApple = function() {
    var spaceFound = false;
    do {
      var randomRow = Math.floor(Math.random() * this.height);
      var randomCol = Math.floor(Math.random() * this.width);
      if (this.isEmpty(randomRow, randomCol)) {
        spaceFound = true;
        this.apples.push(new Snakes.Coord(randomRow, randomCol));
      }
    } while(!spaceFound);
  };

  Board.prototype.isEmpty = function(row, col) {
    var occupied = this.snake.segments.concat(this.apples);
    for (var i = 0, l = occupied.length; i < l; i++) {
      if (occupied[i].row === row && occupied[i].col === col) {
        return false;
      }
    }
    return true;
  };

  Board.prototype.move = function(){
    var snakeHead = this.snake.move();
    this.eatApples(snakeHead)
    return snakeHead;
  }

  Board.prototype.eatApples = function(snakeHead){
    var that = this
    this.apples.some(function(apple, i){
      if (apple.eq(snakeHead)){
        that.apples.splice(i , 1);
        that.snake.grow();
        that.applesEaten++;
        return true;
      }
    });
  }

})(this)