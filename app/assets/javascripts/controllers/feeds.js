'use strict';

angular.module('tidal')
  .controller('FeedsCtrl', ['$scope', '$http', function ($scope, $http) {
    $http.get('/api/feeds').then(function (data) {
      console.log(data);
        $scope.feeds = data.data;
    });
  }]);