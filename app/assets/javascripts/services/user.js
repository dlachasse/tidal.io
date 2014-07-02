'use strict';

angular.module('tidal')
  .factory('user', [function () {
    var user = window.current_user;

    return {
      id: user.id,
      name: user.name,
      email: user.email
    };
  }]);