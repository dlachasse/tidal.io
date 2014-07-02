'use strict';

angular.module('tidal')
  .controller('FeedCtrl', ['$scope', '$stateParams', 'article', function ($scope, $stateParams, article) {

  	var feedId = $stateParams.id;

  	article.get(feedId).then(function (data) {
	  	$scope.articles = data.data;
	  });
  }]);