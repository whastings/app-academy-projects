/**
 * A constructor-less prototypal inheritance utility.
 *
 * Inspiration: Kyle Simpson's 'De"construct"ion':
 *   http://davidwalsh.name/javascript-objects-deconstruction
 */
var newProto = (function() {
  "use strict";

  var getProperties = function(object) {
    var properties = {};
    for (var property in object) {
      if (!object.hasOwnProperty(property)) {
        continue;
      }
      properties[property] = { value: object[property] };
    }
    return properties;
  };

  return function(proto, superProto) {
    if (superProto) {
      proto = Object.create(superProto, getProperties(proto));
    }
    proto.create = function() {
      var newObject = Object.create(proto);
      if (typeof proto.initialize === 'function') {
        proto.initialize.apply(newObject, arguments);
      }
      return newObject;
    };
    return proto;
  };

})();

/* Tests */

var Computer = newProto({
  initialize: function(memory, ghz) {
    this.memory = memory;
    this.ghz = ghz;
  },
  stats: function() {
    return 'Memory: ' + this.memory + '\nGHz: ' + this.ghz + '\n';
  }
});

var basicComputer = Computer.create(1024, 2.5);
console.log(basicComputer.__proto__ === Computer);
console.log(basicComputer.stats());

var UltraBook = newProto({
  initialize: function(memory, ghz, resolution, extras) {
    Computer.initialize.call(this, memory, ghz);
    this.resolution = resolution;
    this.extras = extras;
  },
  stats: function() {
    return Computer.stats.call(this) +
      'Resolution: ' + this.resolution + '\nExtras: ' + this.extras;
  }
}, Computer);

console.log(ultraComputer.__proto__ === UltraBook);
var ultraComputer = UltraBook.create(4096, 3.5, '1920x1080', 'SDD, webcam');
console.log(ultraComputer.stats());
