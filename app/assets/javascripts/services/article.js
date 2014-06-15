'use strict';

angular.module('tidal')
  .factory('article', ['$http', function ($http) {
    var API_URL = '/api/article';

    return {
      get: function (id) {
        return $http(API_URL + '/' + id);
      },
      update: function (id, data) {
        return $http.put(API_URL + '/' + id, data);
      }
    };
  }]);