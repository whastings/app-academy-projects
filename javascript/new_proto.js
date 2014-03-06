/**
 * A constructor-less prototypal inheritance utility.
 *
 * Inspiration: Kyle Simpson's 'De"construct"ion':
 *   http://davidwalsh.name/javascript-objects-deconstruction
 *
 * Credits:
 *   - Mark Shlick for the callSuper idea.
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
      proto.callSuper = function(methodName) {
        if (typeof superProto[methodName] !== 'function') {
          throw new Error('Method ' + methodName + ' is not defined.');
        }
        var args = Array.prototype.slice.call(arguments, 1);
        return superProto[methodName].apply(this, args);
      };
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

/* Tests / Usage Example */

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
console.log(Object.getPrototypeOf(basicComputer) === Computer);
console.log(basicComputer.stats());

var UltraBook = newProto({
  initialize: function(memory, ghz, resolution, extras) {
    this.callSuper('initialize', memory, ghz);
    this.resolution = resolution;
    this.extras = extras;
  },
  stats: function() {
    return this.callSuper('stats') +
      'Resolution: ' + this.resolution + '\nExtras: ' + this.extras;
  }
}, Computer);

var ultraComputer = UltraBook.create(4096, 3.5, '1920x1080', 'SDD, webcam');
console.log(Object.getPrototypeOf(ultraComputer) === UltraBook);
console.log(ultraComputer.stats());
