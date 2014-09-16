'use strict';

angular.module('tidal')
  .config(function ($stateProvider) {
    $stateProvider
      .state('feeds', {
        abstract: true,
        url: '/feeds/',
        template: '<ui-view />'
      })
      .state('feeds.list', {
        url: '',
        templateUrl: 'feeds-list.html',
        controller: 'FeedsListCtrl'
      })
      .state('feeds.single', {
        url: '/:id',
        templateUrl: 'feeds-single.html',
        controller: 'FeedsSingleCtrl'
      });
  });
