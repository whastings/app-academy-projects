;(function() {
  'use strict';

  var range = function(start, end) {
    return start === end ? [end] : [start].concat(range(start + 1, end));
  };
  console.log(range(0, 10));

  var sumIter = function(arr) {
    return arr.reduce(function(sum, el){ return sum + el; }, 0);
  };
  console.log(sumIter(range(0, 10)));

  var sumRecurse = function(arr) {
    return arr.length === 1 ? arr[0] : arr.pop() + sumRecurse(arr);
  };
  console.log(sumRecurse(range(0, 10)));

  var exp1 = function(base, exp) {
    return exp === 0 ? 1 : base * exp1(base, exp - 1);
  };
  console.log(exp1(3, 3));

  var exp2 = function(base, exp) {
    if (exp === 0) {
      return 1;
    } else if (exp % 2 === 0) {
      var result = exp2(base, exp / 2);
      return result * result;
    } else {
      var result = exp2(base, (exp - 1) / 2);
      return result * result * base;
    }
  };
  console.log(exp1(3, 3));

  var fib = function(n) {
    if (n <= 2) { return [0, 1].slice(0, n); }
    var prev = fib(n - 1);
    var prevLen = prev.length;
    return prev.concat(prev[prevLen - 1] + prev[prevLen - 2]);
  };
  console.log(fib(10));

  var bsearch = function(arr, item) {
    var arrLength = arr.length,
        mid = Math.floor(arrLength / 2),
        midItem = arr[mid];

    if (arr.length === 1 && arr[0] !== item) {
      return null;
    } else if (midItem === item) {
      return mid;
    } else if (midItem > item) {
      return bsearch(arr.slice(0, mid), item);
    } else { // greater than item
      var prev = bsearch(arr.slice(mid, arrLength), item);
      return prev === null ? null : mid + prev;
    }
  };
  console.log(bsearch([1, 2, 3, 4, 5, 6, 7, 8], 6));

  var makeChange = function(amt, coins) {
    coins = coins || [25, 10, 5, 1];
    coins = coins.sort(function(a, b) {
      return a - b;
    }).reverse();
    var len = coins.length;

    if (amt < coins[len - 1]) { return []; }
    if (coins[len-1] === amt) { return [amt]; }

    var result = coins.filter(function(el) { return el <= amt; })
    .map(function(el, i, arr) {
      return [el].concat(makeChange(amt-el, arr.slice(i)));
    })
    .sort(function(a, b) { return a.length - b.length; });
    return result[0];
  };
  console.log(makeChange(35, [10, 7, 1]));
  console.log(makeChange(14, [10, 7, 1]));
  console.log(makeChange(99));

  var merge = function(arr1, arr2) {
    var merged = [];
    while (arr1.length > 0 && arr2.length > 0) {
      var lesser = (arr1[0] < arr2[0]) ? arr1.shift() : arr2.shift();
      merged.push(lesser);
    }
    return merged.concat(arr1, arr2);
  };

  var mergeSort = function(arr) {
    var len = arr.length,
        mid = Math.floor(len / 2);
    var sorted = arr.every(function(el, i) {
      return i === (len - 1) ? true : el <= arr[i + 1];
    });
    if (sorted) { return arr; }
    return merge(
      mergeSort(arr.slice(0, mid)),
      mergeSort(arr.slice(mid))
    );
  };

  console.log(mergeSort([1, 3, 2, 6, 4, 8, 5, 2, 9]));

  var subsets = function(arr) {
    if ( arr.length === 0 ) { return [[]]; }
    var current = arr.pop(),
        subs = subsets(arr),
        product = subs.map(function(el) { return el.concat(current); });
    return subs.concat(product);
  };

  console.log(subsets([1,2,3]));

}());
