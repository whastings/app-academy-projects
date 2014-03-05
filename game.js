(function(root) {

  var Asteroids = root.Asteroids = root.Asteroids || {};
  var Asteroid = Asteroids.Asteroid;

  var DIM_X = 500,
      DIM_Y = 300,
      FPS = 30;

  var Game = Asteroids.Game = function(context) {
    this.context = context;
    this.asteroids = Game.addAsteroids(4);
  };

  Game.addAsteroids = function(numAsteroids) {
    var asteroids = [];
    for (var i = 0; i < numAsteroids; i++) {
      asteroids.push(Asteroid.randomAsteroid(DIM_X, DIM_Y));
    }
    return asteroids;
  };

  Game.prototype.draw = function() {
    var context = this.context;
    context.clearRect(0, 0, DIM_X, DIM_Y);
    this.asteroids.forEach(function(asteroid) {
      asteroid.draw(context);
    });
  };

  Game.prototype.move = function() {
    this.asteroids.forEach(function(asteroid) {
      asteroid.move();
    });
  };

  Game.prototype.step = function() {
    this.move();
    this.draw();
  };

  Game.prototype.start = function() {
    setInterval(Game.prototype.step.bind(this), FPS);
  };

})(this);