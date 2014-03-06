(function(root) {

  var Asteroids = root.Asteroids = root.Asteroids || {};
  var Asteroid = Asteroids.Asteroid;
  var Ship = Asteroids.Ship;

  var DIM_X = 1000,
      DIM_Y = 500,
      FPS = 30;

  var Game = Asteroids.Game = function(context) {
    this.context = context;
    this.asteroids = Game.addAsteroids(1);
    this.ship = new Ship([DIM_X/2, DIM_Y/2]);
  };

  Game.addAsteroids = function(numAsteroids) {
    var asteroids = [];
    for (var i = 0; i < numAsteroids; i++) {
      asteroids.push(Asteroid.randomAsteroid(DIM_X, DIM_Y));
    }
    return asteroids;
  };

  Game.prototype.bindKeyHandlers = function() {
    key('j', this.ship.rotateCounterClockwise.bind(this.ship))
    key('k', this.ship.rotateClockwise.bind(this.ship))
    key('a', this.ship.power.bind(this.ship, 1))
    key('d', this.ship.power.bind(this.ship, -1))
  }

  Game.prototype.cleanUp = function() {
    var that = this;
    var outOfBoundsAsteroids = [];
    this.asteroids.forEach(function(asteroid, i) {
      if(that.isOutOfBounds(asteroid)) {
        outOfBoundsAsteroids.push(i);
      }
    })
    outOfBoundsAsteroids.forEach(function(i) {
      that.asteroids.splice(i, 1);
    })
    if (this.isOutOfBounds(this.ship)) {
      this.ship.pos = ([DIM_X/2, DIM_Y/2]);
    }
  }

  Game.prototype.draw = function() {
    var context = this.context;
    context.clearRect(0, 0, DIM_X, DIM_Y);
    this.asteroids.forEach(function(asteroid) {
      asteroid.draw(context);
    });

    this.ship.draw(context);
  };

  Game.prototype.move = function() {
    this.asteroids.forEach(function(asteroid) {
      asteroid.move();
    });
    this.ship.move();
  };

  Game.prototype.checkCollision = function() {
    var ship = this.ship,
        collision = false;
    this.asteroids.some(function(asteroid) {
      if (asteroid.isCollidedWith(ship)) {
        collision = true
        return true;
      }
    });
    if (collision) {
      alert('Game over!');
      this.stop();
    }
  }

  Game.prototype.isOutOfBounds = function (moveableObject) {
    if (moveableObject.pos[0] > DIM_X || moveableObject.pos[1] > DIM_Y) {
      return true;
    }
    return false;
  }

  Game.prototype.step = function() {
    this.move();
    this.draw();
    this.checkCollision();
    this.cleanUp();
  };

  Game.prototype.start = function() {
    this.bindKeyHandlers();
    this.interval = setInterval(Game.prototype.step.bind(this), FPS);
  };

  Game.prototype.stop = function() {
    clearInterval(this.interval);
  };

})(this);