'use strict';

angular.module('tidal')
  .controller('NewSubscriptionCtrl', ['$scope', '$http', function ($scope, $http) {
      var API_URL = '/api/feeds/new';

      var urlPattern = /^.+\.\w{2,}$/i;

      var isValidURL = function (url) {
        return urlPattern.test(url)
      };

      $scope.url = '';

      $scope.addSubscription = function (shit) {
        console.log('addSubscription() fired.', $scope.url);

        if (isValidURL  ($scope.url)) {
          // $http.get(API_URL, {
          //   url: $scope.url
          // }).success(function (data) {
          //   console.log(data);
          // }).error(function (data) {
          //   console.log(data);
          // });
        } else {
          /** @todo Deal with URL errors */
        }
      };
  }])

  /**
   * @todo Move this directive into a separate file.
   * @link http://stackoverflow.com/a/21376148
   */
  .directive('ignoreType', function() {
    return {
      priority: 500,
      compile: function(el, attrs) {
        attrs.$set('type',
          null,
          false
        );
      }
    }
  });