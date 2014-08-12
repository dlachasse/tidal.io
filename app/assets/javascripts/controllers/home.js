'use strict';

angular.module('tidal')
  .controller('HomeCtrl', ['$scope', 'user', '$http', function ($scope, user, $http) {
    $scope.user = user;

    $http.get('api/users/' + user.id + '/feeds').then(function (data) {
      $scope.articles = data.data;
    });
  }]);