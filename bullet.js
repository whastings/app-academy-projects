(function(root){

  var Asteroids = root.Asteroids = root.Asteroids || {};
  var MovingObject = Asteroids.MovingObject;

  var COLOR = "black",
      RADIUS = 2,
      SPEED_MULTIPLIER = 10;

  var Bullet = Asteroids.Bullet = function(pos, vel) {
    var ourVel = [];
    ourVel.push(vel[0] === 0 ? SPEED_MULTIPLIER : vel[0] * SPEED_MULTIPLIER);
    ourVel.push(vel[1] === 0 ? SPEED_MULTIPLIER : vel[1] * SPEED_MULTIPLIER);

    MovingObject.call(this, pos, ourVel, RADIUS, COLOR);
    // this.speed = Math.sqrt(Math.pow(vel[0], 2) + Math.pow(vel[1], 2));
  }
  Bullet.inherits(MovingObject);


})(this)