/* Pair programming partner: Shah Rukh Paracha */

"use strict";

var readline = require('readline');

var READER = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var askLessThan = function(el1, el2, callback) {
  READER.question('Is ' + el1 + ' less than ' + el2 + ' ?', function(response) {
    if (response === 'yes') {
      callback(true);
    } else {
      callback(false);
    }
  });
};

var performSortPass = function(arr, i, madeAnySwaps, callback) {
  if (i < arr.length - 1) {
    askLessThan(arr[i], arr[i+1], function(response) {
      if (!response) {
        var old = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = old;
        performSortPass(arr, i+1, true, callback);
      } else {
        performSortPass(arr, i+1, false, callback);
      }
    });
  } else {
    callback(madeAnySwaps);
  }
};

var crazyBubbleSort = function(arr, sortCompletionCallback) {
  var sortPassCallback = function(response) {
    if (response){
      performSortPass(arr, 0, false, sortPassCallback);
    } else {
      READER.close();
      sortCompletionCallback(arr);
    }
  };
  sortPassCallback(true);
};

crazyBubbleSort([3,2,1], function(arr) { console.log(arr) });
