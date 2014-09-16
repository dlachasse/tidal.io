'use strict';

angular.module('tidal')
  .controller('NavigationCtrl', function ($scope, user, $http) {
    var API_URL = '/api/feeds';

    var urlPattern = /^.+\.\w{2,}.*$/i;

    var isValidURL = function (url) {
      return urlPattern.test(url)
    };

    $scope.user = user;

    $scope.url = '';

    $scope.addSubscription = function (shit) {
      console.log('addSubscription() fired.', $scope.url);

      if (isValidURL($scope.url)) {
        $http.post(API_URL, {
          feed_url: $scope.url
        }).success(function (data) {
          console.log(data);
        }).error(function (data) {
          console.log(data);
        });
      } else {
        console.log('Error: invalid form URL');
        /** @todo Deal with URL errors */
      }
    };
  })

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
