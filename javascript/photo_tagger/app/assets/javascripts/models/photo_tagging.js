
(function(root) {

  var PT = root.PT = (root.PT || {});

  var PhotoTagging = PT.PhotoTagging = function(attributes) {
    this.attributes = _.extend({}, attributes);
  };

  _.extend(PhotoTagging, {
    fetchByPhotoId: function(photoId, callback) {
      $.ajax({
        url: '/api/photos/' + photoId + '/photo_taggings',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
          var objects = _.map(data, function(object) {
            return new PhotoTagging(object);
          });
          PhotoTagging.all = objects;
          callback(objects);
        }
      });
    },

    on: function(eventName, callback) {
      if (!this._events[eventName]) {
        this._events[eventName] = [];
      }
      this._events[eventName].push(callback);
    },

    trigger: function(eventName) {
      if (!this._events[eventName]) {
        return;
      }
      this._events[eventName].forEach(function(callback) {
        callback();
      });
    },

    find: function(id) {
      return _.find(this.all, function(photo) {
        return photo.get('id') === id;
      });
    },

    all: [],

    _events: {}
  });

  _.extend(PhotoTagging.prototype, {
    get: function(attr_name) {
      return this.attributes[attr_name];
    },

    set: function(attr_name, val) {
      this.attributes[attr_name] = val;
      return this;
    },

    create: function(callback) {
      if (this.attributes.id !== undefined) {
        return;
      }
      PhotoTagging.all.push(this);
      PhotoTagging.trigger('add');
      this.sendData(callback, '/api/photo_taggings', 'POST');
    },

    save: function(callback) {
      if (this.attributes.id !== undefined) {
        this.sendData(callback, "/api/photo_taggings/" + this.attributes.id, 'PUT');
      } else {
        this.create(callback);
      }
    },

    sendData: function(callback, url, type) {
      var self = this;
      $.ajax({
        url: url,
        type: type,
        data: {photo_tagging: this.attributes},
        dataType: "json",
        success: function(data) {
          _.extend(self.attributes, data);
          callback();
        }
      });
    }

  });

})(this);
