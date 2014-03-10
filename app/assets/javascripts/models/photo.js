
(function(root) {

  var PT = root.PT = (root.PT || {});

  var Photo = PT.Photo = function(attributes) {
    this.attributes = _.extend({}, attributes);
  };

  _.extend(Photo, {
    fetchByUserId: function(userId, callback) {
      $.ajax({
        url: '/api/users/' + userId + '/photos',
        type: 'GET',
        dataType: 'json',
        success: function(data) {
          var objects = _.map(data, function(object) {
            return new Photo(object);
          });
          Photo.all = Photo.all.concat(objects);
          callback(objects);
        }
      });
    },

    all: []
  });

  _.extend(Photo.prototype, {
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
      Photo.all.push(this);
      this.sendData(callback, '/api/photos', 'POST');
    },

    save: function(callback) {
      if (this.attributes.id !== undefined) {
        this.sendData(callback, "/api/photos/" + this.attributes.id, 'PUT');
      } else {
        this.create(callback);
      }
    },

    sendData: function(callback, url, type) {
      $.ajax({
        url: url,
        type: type,
        data: this.attributes,
        dataType: "json",
        success: function(data) {
          _.extend(this.attributes, data);
          callback();
        }
      });
    }

  });

})(this);
