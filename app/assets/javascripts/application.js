// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require vendor/fastclick/lib/fastclick.js
//= require vendor/angular/angular.min.js
//= require vendor/angular-resource/angular-resource.min.js
//= require vendor/angular-route/angular-route.min.js
//= require vendor/angular-sanitize/angular-sanitize.min.js
//= require vendor/angular-ui-router/release/angular-ui-router.min.js
//
// Get all the Angular templates
// (https://github.com/pitr/angular-rails-templates)
//= require angular-rails-templates
//= require_tree ../templates

angular.module('tidal', [
  'ngResource',
  'ngRoute',
  'ngSanitize',
  'ui.router',
  'templates'
]);

// Load configuration files
//= require_tree ./config

angular.module('tidal').value('API_KEY', 'M57GbkrIIQwiYf0E42Tvtwtt');

angular.module('tidal').controller('HomeCtrl', [
  '$scope',
  '$http',
  'API_KEY',
  function ($scope, $http, API_KEY) {
    var feeds = getFeeds();

    feeds.then(function (data) {
      $scope.feeds = data.data;
    });

    function getFeeds() {
      $http.defaults.headers.common.Authorization = 'Token token=' + API_KEY;
      $http.defaults.headers.common.Accept = 'application/tidal.v1';

      return $http.get('/api/feeds');
    }
  }]);