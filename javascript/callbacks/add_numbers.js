/* Pair programming partner: Shah Rukh Paracha */

"use strict";

var readline = require('readline');

var READER = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var getNumber = function(callback) {
  READER.question('Enter a number:', callback);
};

var addNumbers = function(sum, numsLeft, completionCallback) {
  if (numsLeft === 0) {
    completionCallback(sum);
    return;
  }
  getNumber(function(response) {
    sum += +response;
    console.log('Current sum: ' + sum);
    numsLeft--;
    addNumbers(sum, numsLeft, completionCallback);
  });
};

addNumbers(0, 3, function(sum) {
  console.log("Total Sum: " + sum);
  READER.close();
});
