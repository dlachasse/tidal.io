// Tidal Application Manifest
//
// This file loads the application's scripts in the appropriate order
// and bootstraps the thing.
//
//= require angular
//= require angular-sanitize
//= require angular-ui-router

'use strict';

angular.module('tidal', [
  'ngSanitize',
  'ui.router'
  //'templates'
])
  .config(function ($urlRouterProvider, $locationProvider) {
    $urlRouterProvider
      .otherwise('/');

    $locationProvider.html5Mode(true);
  });
