'use strict';

angular.module('tidal')
  .config(['$stateProvider', function ($stateProvider) {
    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'home.html',
        controller: 'HomeCtrl'
      })
      .state('feeds', {
        url: '/feeds',
        templateUrl: 'feeds.html',
        controller: 'FeedsCtrl'
      })
      .state('feed', {
        url: '/feed/:id',
        templateUrl: 'feed.html',
        controller: 'FeedCtrl'
      });
  }]);