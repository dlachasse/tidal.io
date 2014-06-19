'use strict';

angular.module('tidal')
  .controller('HomeCtrl', ['$scope', 'user', function ($scope, user) {
    var user = new user

    $scope.message = 'Welcome!';

    // $scope.feeds = [
    //   {
    //     id: 1,
    //     name: 'test 1',
    //   }, {
    //     id: 2,
    //     name: 'test 2'
    //   },
    //   {
    //     id: 3,
    //     name: 'test 3'
    //   }
    // ];
  }]);