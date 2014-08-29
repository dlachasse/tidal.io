'use strict';

angular.module('tidal')
  .controller('HomeCtrl', ['$scope', 'user', '$http', function ($scope, user, $http) {
    var ARTICLE_COUNT = 10;

    $scope.user = user;
    $scope.start = 0;

    var getArticlesUrl = function (count, start) {
      if ('id' in user) {
        return 'api/users/' + user.id + '/feeds';
      }
    };
    var getArticlesConfig = function (start) {
      // Set default for `start`
      if (typeof start === 'undefined') {
        start = 0;
      }

      return {
        params: {
          count: ARTICLE_COUNT,
          'start': start
        }
      }
    };

    // Get initial load of articles
    $http.get(getArticlesUrl(), getArticlesConfig())
      .then(function (data) {
        $scope.articles = data.data;
      });
  }]);