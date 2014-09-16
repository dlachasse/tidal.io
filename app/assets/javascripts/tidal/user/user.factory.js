'use strict';

angular.module('tidal')
  .factory('user', [function () {
    var id = 0;
    var name = '';
    var email = '';

    if (typeof window.current_user !== 'undefined') {
      id = window.current_user.id;
      name = window.current_user.name;
      email = window.current_user.email;
    }

    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }]);