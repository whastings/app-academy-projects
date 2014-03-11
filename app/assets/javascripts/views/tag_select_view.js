
(function(root) {

  var PT = root.PT = (root.PT || {});

  var TagSelectView = PT.TagSelectView = function(photo, event) {
    this.photo = photo;
    this.$el = $('<div>');
    var x = event.offsetX - 50;
    var y = event.offsetY - 50;
    this.$el.css({
      "left": x + "px",
      "top": y + "px"
    });
  };

  _.extend(TagSelectView.prototype, {
    render: function() {
      var $innerDiv = $('<div>');
      this.$el.addClass('tag');
      this.$el.append($innerDiv);
      return this;
    }
  });

})(this);