;(function() {
  'use strict';

  Array.prototype.dups = function() {
    var dups = [];
    for (var i = 0, len = this.length; i < len; i++) {
      if (dups.indexOf(this[i]) === -1) {
        dups.push(this[i]);
      }
    }
    return dups;
  };

  Array.prototype.twoSum = function() {
    var sums = [];
    for (var i = 0, ilen = this.length - 1; i < ilen; i++) {
      for (var j = i + 1, jlen = this.length; j < jlen; j++) {
        if (this[i] + this[j] === 0) {
          sums.push([i, j]);
        }
      }
    }
    return sums;
  };

  Array.prototype.transpose = function() {
    var trans = [];
    for (var i = 0, len = this[0].length; i < len; i++) {
      trans.push([]);
    }
    for (var i = 0, iLen = this.length; i < iLen; i++) {
      for (var j = 0, jLen = this[i].length; j < jLen; j++) {
        trans[i].push(this[j][i]);
      }
    }
    return trans;
  };

}());

_l = console.log;

console.log([1, 2, 3, 2, 1].dups());

_l([-1, 0, 2, -2, 1].twoSum());

rows = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8]
];
_l(rows.transpose());
