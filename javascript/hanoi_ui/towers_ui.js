(function(root) {

  var Hanoi = root.Hanoi = (root.Hanoi || {});
  var TowersUI = Hanoi.TowersUI = function(game) {
    this.game = game;
    this.selectedPile = null;
    this.$container = $(".container");
    this.addClickHandlers();

  };

  TowersUI.prototype.addClickHandlers = function(){
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
        alert('Invalid Move')
      }
      $startPile.removeClass('selected');
      this.selectedPile = null;
    }
  };

  TowersUI.prototype.moveDisk = function($startPile, $endPile) {
    var disk = $startPile.children().first().remove();
    var diskNum = disk.data('id');
    disk.removeClass().addClass('disk disk-' + diskNum);
    var pile = this.game.towers[$endPile.data('id')];
    disk.addClass('order-' + (pile.length - 1));
    disk.prependTo($endPile);
  }

})(this);