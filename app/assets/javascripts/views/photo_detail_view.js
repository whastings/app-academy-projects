
(function(root) {

  var PT = root.PT = (root.PT || {});

  var PhotoDetailView = PT.PhotoDetailView = function(photo) {
    this.photo = photo;
    this.$el = $('<div>');
    this.template = JST['photo_detail'];
    this.$el.on('click', '.backlink', this.goBack.bind(this) );
    this.$el.on('click', '.photo', this.popTagSelectView.bind(this));

  }

  _.extend(PhotoDetailView.prototype, {
    render: function() {
      var content = this.template({photo: this.photo});
      this.$el.html(content);
    },

    goBack: function(event) {
      PT.showPhotosIndex();
    },

    popTagSelectView: function(event) {
      var $photo = this.$el.find('.photo');
      $photo.css('width', this.$el.find('img').width());

      var selectView = new PT.TagSelectView(this.photo, event);
      $photo.append(selectView.render().$el);
    }
  });



})(this);