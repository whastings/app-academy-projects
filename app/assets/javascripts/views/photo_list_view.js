(function(root) {
  var PT = root.PT = (root.PT || {});

  var PhotosListView = PT.PhotosListView = function() {
    this.$el = $('<div>');
    PT.Photo.on('add', this.render.bind(this));
  };

  _.extend(PhotosListView.prototype, {
    render: function() {
      this.$el.empty();
      var $ul = $('<ul>');
      this.$el.append($ul);
      PT.Photo.all.forEach(function(photo) {
        var $li = $('<li>');
        $li.html(photo.get('title'));
        $ul.append($li);
      });
      return this;
    }
  });

})(this);