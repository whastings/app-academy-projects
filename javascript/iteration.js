/* Pair programming partner: Mark Shlick */

;(function() {
  'use strict';

  var bubbleSort = function(arr, callback) {
    var sorted = true;
    for (var i = 0, len = arr.length - 1; i < len; i++) {
      if ( !callback(arr[i], arr[i+1]) ) {
        var temp = arr[i];
        arr[i] = arr[i + 1];
        arr[i + 1] = temp;
        sorted = false;
      }
    }
    return !sorted ? bubbleSort(arr, callback) : arr;
  };

  var res = bubbleSort([9, 8, 7, 6, 5, 4, 3, 2, 1], function(current, next) {
    return current < next;
  });
  console.log(res);

  var substrings = function(str) {
    var subs = [];
    for (var i = 0, ilen = str.length; i < ilen; i++) {
      for (var j = i, jlen = str.length; j < jlen; j++) {
        if ( j > i) {
          subs.push(str.slice(i, j + 1));
        } else {
          subs.push(str[i]);
        }
      }
    }
    return subs;
  };

  console.log(substrings("hello"));

}());
