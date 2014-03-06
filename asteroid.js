(function(root){

  var COLOR = "gray";
  var RADIUS = 20;

  var Asteroids = root.Asteroids = root.Asteroids || {};

  var Asteroid = Asteroids.Asteroid = function(pos, vel) {
    Asteroids.MovingObject.call(this, pos, vel, RADIUS, COLOR);
  }

  Asteroid.inherits(Asteroids.MovingObject);

  Asteroid.randomAsteroid = function(dimX, dimY) {
    var posX = Math.floor(Math.random() * dimX)
    var posY = Math.floor(Math.random() * dimY)

    var vel = [Asteroid.randomVec(), Asteroid.randomVec()];

    return new Asteroid([posX, posY], vel);
  }

  Asteroid.randomVec = function(){
    var vel = Math.random()*20 + 1;
    vel *= Math.floor(Math.random()*2) == 1 ? 1 : -1;
    return vel;
  }


})(this)