'use strict';

angular.module('tidal')
  .controller('HomeCtrl', ['$scope', 'user', 'feed', function ($scope, user, feed) {

    $scope.message = 'Welcome!';

    $scope.user = user;

    feed.get().then(function (data) {
      $scope.feeds = data.data;
    });
  }]);