
(function(root) {

  var PT = root.PT = (root.PT || {});

  var PhotoFormView = PT.PhotoFormView = function() {
    this.$el = $('<div>');
    this.template = JST["photo_form"];
    this.$el.on('submit', 'form', this.submit.bind(this));
  };

  _.extend(PhotoFormView.prototype, {
    render: function() {
      var content = this.template();
      this.$el.html(content);
      return this;
    },

    submit: function(event) {
      event.preventDefault();
      var $form = $(event.target);
      var photoData = $form.serializeJSON();
      var photo = new PT.Photo(photoData.photo);
      photo.create(function() {
        $form[0].reset();
      });
    }
  });

})(this);