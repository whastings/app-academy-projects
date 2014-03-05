/* Pair programming partner: Shah Rukh Paracha */

"use strict";

var Clock = function(){
};

Clock.prototype.run = function() {
  var startTime = new Date();
  this.hours = startTime.getHours();
  this.minutes = startTime.getMinutes();
  this.seconds = startTime.getSeconds();
  this.tick();
  setInterval(this.tick.bind(this), 5000);
};

Clock.prototype.display = function () {
  var seconds = this.seconds + 1;
  var minutes = this.minutes + 1;
  var hours = this.hours;
  console.log(hours + ":" + minutes + ":" + seconds);
}

Clock.prototype.tick = function() {
  this.seconds += 5;
  if (this.seconds > 59) {
    this.minutes += 1;
    this.seconds = (this.seconds - 59);
  }
  if (this.minutes > 59) {
    this.hours += 1;
    this.minutes = 0;
  }
  if (this.hours > 23) {
    this.hours = 0;
  }
  this.display();
};

var clock = new Clock();

clock.run();
