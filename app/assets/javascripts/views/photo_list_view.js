(function(root) {
  var PT = root.PT = (root.PT || {});

  var PhotosListView = PT.PhotosListView = function() {
    this.$el = $('<div>');
    PT.Photo.on('add', this.render.bind(this));
    this.$el.on('click', 'a', this.showDetail.bind(this));
    this.template = JST['photos_list'];
  };

  _.extend(PhotosListView.prototype, {
    render: function() {
      this.$el.empty();
      var content = this.template({
        photos: PT.Photo.all
      });
      this.$el.html(content);
      return this;
    },

    showDetail: function(event) {
      event.preventDefault();
      var $a = $(event.target);
      var photoId = $a.data('id');
      var photo = PT.Photo.find(photoId);
      PT.showPhotoDetail(photo);
    }
  });

})(this);