;(function(root){
  var Snakes = root.Snakes = (root.Snakes || {});

  var Coord = Snakes.Coord = function(row, col) {
    this.row = row;
    this.col = col;
  };

  Coord.prototype.plus = function(direction) {
    var newCoord = new Coord(this.row, this.col);
    switch(direction) {
    case 'N':
      newCoord.row -= 1;
      break;
    case 'E':
      newCoord.col += 1;
      break;
    case 'S':
      newCoord.row += 1;
      break;
    case 'W':
      newCoord.col -= 1;
      break;
    }
    return newCoord;
  };

  Coord.prototype.eq = function(other){
    return (this.row === other.row && this.col === other.col)
  }

})(this);