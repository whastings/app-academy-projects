// This is a manifest file that'll be compiled into application.js,
// which will include all the files listed below.
//
// Any JavaScript/Coffee file within this directory,
// lib/assets/javascripts, vendor/assets/javascripts, or
// vendor/assets/javascripts of plugins, if any, can be referenced
// here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll
// appear at the bottom of the the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE
// PROCESSED, ANY BLANK LINE SHOULD GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.serializeJSON
//= require underscore
//
//= require_tree ./models
//= require_tree ./views
//= require_tree ../templates
//
//= require_tree .

(function(root) {

  var PT = root.PT = (root.PT || {});

  PT.initialize = function(userId) {
    this.userId = userId;
    this.showPhotosIndex(userId);
  };

  PT.showPhotosIndex = function() {
    PT.Photo.fetchByUserId(this.userId, function() {
      var view = new PT.PhotosListView();
      var formView = new PT.PhotoFormView();
      view.render();
      formView.render();
      $('div#content').html(view.$el).append(formView.$el);
    });
  };

  PT.showPhotoDetail = function(photo) {
    var view = new PT.PhotoDetailView(photo);
    view.render();
    $('div#content').html(view.$el);
  };

})(this);
