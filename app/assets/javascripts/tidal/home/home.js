'use strict';

angular.module('tidal')
  .config(function ($stateProvider) {
    $stateProvider.state('home', {
      url: '/',
      templateUrl: 'home.html',
      controller: 'HomeCtrl'
    });
  });