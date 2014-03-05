/* Pair programming partner: Shah Rukh Paracha */

Function.prototype.myBind = function(thisArg) {
  var that = this;
  return function() {
    return that.apply(thisArg);
  };
};

var obj = {
  name: 'Bob',
  getName: function() {
    return this.name;
  }
};

var boundName = obj.getName.myBind(obj);
console.log(boundName());
