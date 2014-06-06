(function(root) {
  'use strict';

  var Hanoi = root.Hanoi = (root.Hanoi || {});
  var TowersUI = Hanoi.TowersUI = function(game) {
    this.game = game;
    this.selectedPile = null;
    this.$container = $(".container");
    this.addClickHandlers();
  };

  TowersUI.prototype.addClickHandlers = function() {
    var $piles = this.$piles = $(".pile");
    this.$container.on("click", ".pile", this.handleMove.bind(this));
  };

  TowersUI.prototype.handleMove = function(event) {
    var $target = $(event.currentTarget);
    var number = $target.data('id');
    if (this.selectedPile === null) {
      this.selectedPile = number;
      $target.addClass('selected');
    } else {
      var move = this.game.move(this.selectedPile, number);
      var $startPile = this.$piles.eq(this.selectedPile);
      if (move) {
        this.moveDisk($startPile, $target);
        if (this.game.isWon()){
          alert("You Win!");
        }
      } else {
        alert('Invalid Move');
      }
      $startPile.removeClass('selected');
      this.selectedPile = null;
    }
  };

  TowersUI.prototype.moveDisk = function($startPile, $endPile) {
    var oldDisk = $startPile.children().first();
    var disk = oldDisk.clone();
    var diskNum = disk.data('id');
    disk.removeClass().addClass('disk disk-' + diskNum);
    var pile = this.game.towers[$endPile.data('id')];
    disk.addClass('order-' + (pile.length - 1));
    disk.addClass('hidden');
    disk.prependTo($endPile);
    this.animateMove(oldDisk, disk);
  };

  TowersUI.prototype.animateMove = function(oldDisk, newDisk) {
    var newDiskBottom = parseInt(newDisk.css('bottom'));
    var $disks = $('.disk');
    var diskHeights = $.map($disks, function(disk) {
     return parseInt($(disk).css('bottom'));
    });
    var up = Math.max.apply(null, diskHeights) + 45;
    oldDisk.addClass('animated');
    oldDisk.css({bottom: up + 'px'});

    performMove(oldDisk, 'bottom', up)
    .then(function() {
      var oldLeft = oldDisk.offset().left;
      var newLeft = newDisk.offset().left;
      var posLeft = parseInt(oldDisk.css('left'));
      var amount = posLeft + (newLeft - oldLeft);
      return performMove(oldDisk, 'left', amount);
    })
    .then(function() {
      return performMove(oldDisk, 'bottom', newDiskBottom);
    })
    .then(function() {
      newDisk.removeClass('hidden');
      oldDisk.remove();
    });
  };

  var performMove = function(element, property, amount) {
    var deferred = $.Deferred();

    var move = {};
    move[property] = amount + 'px';
    element.css(move);

    element.one(
      'webkitTransitionEnd otransitionend msTransitionEnd transitionend',
      deferred.resolve
    );

    return deferred.promise();
  };

})(this);
