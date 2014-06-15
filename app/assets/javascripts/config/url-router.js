'use strict';

angular.module('tidal')
  .config(['$urlRouterProvider', function ($urlRouterProvider) {
    /**
     * @todo This is redundant because `ui-router` is being used for
     *   all routing. Drop this?
     */
    $urlRouterProvider.otherwise('/');
  }]);