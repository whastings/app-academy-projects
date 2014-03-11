
(function(root) {

  var PT = root.PT = (root.PT || {});

  var TagSelectView = PT.TagSelectView = function(photo, event) {
    this.photo = photo;
    this.$el = $('<div>');
    this.template = JST['photo_tag_options'];
    this.x = event.offsetX - 50;
    this.y = event.offsetY - 50;
    this.$el.css({
      "left": this.x + "px",
      "top": this.y + "px"
    });
    this.$el.on('click', 'li', this.selectTagOption.bind(this));
  };

  _.extend(TagSelectView.prototype, {
    render: function() {
      var $innerDiv = $('<div>');
      var userList = this.template({users: PT.users});
      this.$el.addClass('tag');
      this.$el.append($innerDiv).append(userList);
      return this;
    },

    selectTagOption: function(event) {
      var self = this;

      event.stopPropagation();

      var photoTagging = new PT.PhotoTagging({
        user_id: PT.userId,
        photo_id: this.photo.get('id'),
        x_pos: this.x,
        y_pos: this.y
      });

      photoTagging.create(function() {
        self.$el.remove();
      });

    }
  });

})(this);