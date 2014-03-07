;(function(root){
  var Snakes = root.Snakes = (root.Snakes || {});

  var Snake = Snakes.Snake = function(){

    this.segments = [new Snakes.Coord(2, 0),
                     new Snakes.Coord(1, 0),
                     new Snakes.Coord(0, 0)];
    this.direction = "S";
    this.size = 3;
    this.baseSize = this.size;
  };

  Snake.prototype.move = function(){
    var front = this.segments[0];
    var newSegment = front.plus(this.direction);
    if (this.size === this.segments.length) {
      this.segments.pop();
    } else if (this.size < this.segments.length) {
      this.segments.pop();
      this.segments.pop();
    }
    this.segments.unshift(newSegment);
    return newSegment;
  };

  Snake.prototype.turn = function(newDir){
    if (!(newDir === Snakes.oppositeDirections[this.direction])){
      this.direction = newDir;
    }
  };

  Snakes.oppositeDirections = {
    N: "S",
    E: "W",
    S: "N",
    W: "E"
  }

  Snake.prototype.grow = function(){
    this.size += 2;
  };

  Snake.prototype.shrink = function(){
    if (this.size > this.baseSize){
      this.size -= 1
    }
  }

  Snake.prototype.increaseBaseSize = function() {
    this.baseSize++;
    this.size++;
  };

  Snake.prototype.collided = function() {
    var head = this.segments[0];
    for (var i = 1, l = this.segments.length; i < l; i++) {
      if (head.eq(this.segments[i])) {
        return true;
      }
    }
    return false;
  };

})(this);