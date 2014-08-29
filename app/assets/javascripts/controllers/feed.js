'use strict';

angular.module('tidal')
  .controller('FeedCtrl', ['$scope', '$stateParams', '$http', function ($scope, $stateParams, $http) {

    var feedId = $stateParams.id;

    if (feedId !== 'undefined') {
      /**
       * @todo Abstract feeds and articles into their own services.
       */
      $http.get('/api/feeds/' + feedId + '/articles').then(function (data) {
        $scope.articles = data.data;
      });
    }
  }]);