angular.module('hotelApp',['ui.router','ngResource','hotelApp.controllers','hotelApp.services']);

angular.module('hotelApp').config(function($stateProvider, $httpProvider) {

  $stateProvider.state('hotels', {
    url: '/hotels',
    templateUrl: '/partials/index.html',
    controller: 'ListController'

  }).state('show', {
    url: '/hotels/:id/show',
    templateUrl: '/partials/show.html',
    controller: 'ShowController'

  }).state('newHotel', {
    url: '/hotels/new',
    templateUrl: '/partials/new.html',
    controller: 'CreateController'

  }).state('edit', {
    url: '/hotels/:id/edit',
    templateUrl: '/partials/edit.html',
    controller: 'EditController'


  }).state('search', {
    url: '/search',
    templateUrl: '/partials/search.html',
    controller: 'SearchController'

  });

}).run(function($state){
  $state.go('hotels');
});