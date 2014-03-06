/* Pair programming partner: Chrissie Deist */

var sum = function() {
  var sum = 0;
  for (var i = 0, l = arguments.length; i < l; i++) {
    sum += arguments[i];
  }
  return sum;
};

console.log(sum(1, 2, 3, 4));

Function.prototype.myBind = function(thisArg) {
  var that = this;
  var args = Array.prototype.slice.call(arguments, 1);
  return function() {
    args = args.concat(Array.prototype.slice.call(arguments));
    return that.apply(thisArg, args);
  };
};

var myFunction = function(a, b, c) {
  return this.name + a + b + c;
};
var myBoundFunction = myFunction.myBind({name: 'Joe'}, 1, 2);
console.log(myBoundFunction(3));

Function.prototype.curry = function(numArgs) {
  var i = 0,
      that = this,
      args = [];
  var curriedFunction = function() {
    i++;
    args = args.concat(Array.prototype.slice.call(arguments));
    if (i === numArgs) {
      return that.apply({}, args);
    } else {
      return curriedFunction;
    }
  };
  return curriedFunction;
};

var sum = function(num1, num2, num3) {
  return num1 + num2 + num3;
};

var f1 = sum.curry(3);
var f2 = f1(2)(3)(4);
console.log(f2);
