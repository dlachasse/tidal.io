'use strict';

angular.module('tidal')
  .config(['$resourceProvider', 'API_KEY', function ($resourceProvider, API_KEY) {
    /**
     * Add credentials to every request.
     */
    $resourceProvider.default.headers.common.Authorization = 'Token token=' + API_KEY;
    $resourceProvider.default.headers.common.Accept = 'application/tidal.v1';

    /**
     * Make 'PUT' methods Rails-friendly by changing the HTTP verb to
     * 'PATCH'.
     */
    $resourceProvider.default.headers.put = { method: 'PATCH' };
  }]);