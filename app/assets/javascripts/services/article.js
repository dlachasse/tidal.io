'use strict';

angular.module('tidal')
  .factory('article', ['$http', function ($http) {
    var API_URL = '/api/article';

    return {
      get: function(feedId, count, start) {
        if (count === undefined) {
          count = 10;
        }
        if (start === undefined) {
          start = 1;
        }

        return $http({
          url: API_URL,
          data: {
            'count': count,
            'start': start
          }
        });
      }
    }

    // return {
    //   get: function (id) {
    //     return $http(API_URL + '/' + id);
    //   },
    //   markRead: function (id) {

    //   },
    //   markUnread: function (id) {

    //   },
    //   update: function (id, data) {
    //     return $http.put(API_URL + '/' + id, data);
    //   }
    // };
  }]);