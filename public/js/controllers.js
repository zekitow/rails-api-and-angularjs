angular.module('hotelApp.controllers',[]).controller('ListController', function($scope, $state, confirmDialog, $window, Hotel) {

    $scope.hotels = Hotel.query();

    $scope.remove = function(hotel) {
        if(confirmDialog.show('Are you sure?')) {
            hotel.$remove(function() {
                $window.location.href='/';
            });
        }
    }

})

.controller('ShowController',function($scope, $stateParams, Hotel) {
    $scope.hotel = Hotel.get({ id: $stateParams.id });

})

.controller('CreateController',function($scope, $state, $stateParams, Hotel) {
    $scope.hotel = new Hotel();

    $scope.add = function() {
        $scope.hotel.$save(function() {
            $state.go('hotels');
        });
    }

}).controller('EditController',function($scope, $state, $stateParams, Hotel) {

    $scope.update = function() {
        $scope.hotel.$update(function() {
            $state.go('hotels');
        });
    };

    $scope.loadAll = function() {
        $scope.hotel = Hotel.get({ id: $stateParams.id });
    };
    $scope.loadAll();
})

.controller('SearchController',function($scope, $stateParams, Hotel) {
   // $scope.hotels = [];

   $scope.searchNow = function() {
    // if ($scope.q.length > 3) {
        $scope.hotels = Hotel.search({ q: $scope.q });
    // }
   }
    
});