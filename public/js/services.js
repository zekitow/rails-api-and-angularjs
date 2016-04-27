angular.module('hotelApp.services',[]).factory('Hotel',function($resource) {

  return $resource('http://localhost:3000/api/hotels/:id',{ id:'@id' }, {
    update: { method: 'PUT' },
    remove: { params: { id: '@id' }, method: 'DELETE' },
    search: { url: 'http://localhost:3000/api/search', method: 'GET', isArray: true }
  });
})


.service('confirmDialog',function($window) {
  this.show = function(message) {
    return $window.confirm(message);
  }
});