/* Pair programming partner: Mark Shlick */

;(function() {
  'use strict';

  var _l = console.log;

  var twoMultiples = function(arr) {
    return arr.map(function(el) {
      return el * 2;
    });
  };

  _l(twoMultiples([8, 2, 4, 5, 9]));

  var myEach = function(arr, callback) {
    if (arr.length === 0 ) { return; }
    arr = arr.slice();
    callback(arr.shift());
    myEach(arr, callback);
  };

  myEach([1, 2, 3, 4, 5], function(el) {
    _l(el);
  });

  var myMap = function(arr, callback) {
    var ret = [];
    myEach(arr, function(el){
      ret.push(callback(el));
    });
    return ret;
  };

  _l(myMap([1, 2, 3, 4, 5], function(el) {
    return el*2;
  }));

  var myInject = function(arr, accum, callback) {
    myEach(arr, function(el) {
      accum = callback(accum, el);
    });
    return accum;
  };

  _l(myInject([1, 2, 3, 4, 5], 0, function(accum, el) {
    return accum + el;
  }));

}());
