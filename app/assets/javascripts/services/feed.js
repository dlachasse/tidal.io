 'use strict';

angular.module('tidal')
  .factory('feed', ['$http', function ($http) {
    var API_URL = '/api/feeds';

    return {
      create: function (data) {
        return $http.post(API_URL, data)
      },
      get: function (id) {
        var url;

        if (id != null) {
          url = API_URL + '/id';
        } else {
          url = API_URL;
        }

        return $http.get(url);
      },
      update: function (id, data) {
        return $http.put(API_URL + '/id', data);
      },
      delete: function (id) {
        return $http.delete(API_URL + '/id');
      }
    };
  }]);