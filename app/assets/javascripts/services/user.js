'use strict';

angular.module('tidal')
  .factory('user', ['$http', function ($http) {
    var User = function (userId) {
      this.id = userId;
    };

    User.prototype.get = function () {
      /**
       * @link https://docs.angularjs.org/api/ng/service/$http
       */
      return $http.get('/api/users' + this.id)
        .success(function (data) {
          return data.data;
        })
        .error(function (data, status) {
          console.log('Retrieving user failed', status, data);
        });
    }
  }]);