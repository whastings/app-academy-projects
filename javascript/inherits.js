/* Pair programming partner: Chrissie Deist */

Function.prototype.inherits = function(superClass) {
  var Surrogate = function() {};
  Surrogate.prototype = superClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = superClass;
};

function MovingObject(position, velocity) {
  this.position = position;
  this.velocity = velocity;
}

function Ship(position, velocity, size) {
  MovingObject.call(this, position, velocity);
  this.size = size;
}
Ship.inherits(MovingObject);

function Asteroid(position, velocity, size, numCraters) {
  MovingObject.call(this, position, velocity);
  this.size = size;
  this.numCraters = numCraters;
}
Asteroid.inherits(MovingObject);

var ship1 = new Ship(3, 1, 5);
console.log(ship1.position);

var movingObj = new MovingObject(3, 2);
