var primers = angular.module("fg-primers",
    ["ngRoute", "ngResource"]
);

primers.config(function($routeProvider) {
    $routeProvider
        .when("/primers", {
            controller: "PrimerListController",
            templateUrl: "modules/primers/primerList.html"
        })
        .when("/primers/new", {
            controller: "NewPrimerController",
            templateUrl: "modules/primers/primerDetail.html"
        })
        .when("/primers/new", {
            controller: "NewPrimerController",
            templateUrl: "modules/primers/primerDetail.html"
        })
        .when("/primers/:id", {
            controller: "PrimerDetailController",
            templateUrl: "modules/primers/primerDetail.html"
        });
});

primers.factory("Primer", function($resource) {
    return $resource("primers/:id",
        { id: "@id" },
        { update: { method: "PUT" } }
    );
});

primers.controller("PrimerListController", function($rootScope, $scope, $location, $http) {
    $scope.primers = [];
    $scope.page = 1;
    $scope.endOfResults = false;
    $scope.searchCode = "";
    $scope.searchName = "";
    $scope.searchSequence = "";

    $rootScope.headerLinks.push({ href: "#/primers/new", text: "New Primer" });
    //$rootScope.headerLinks.push({ href: "#/primers/import", text: "Import" });

    $scope.showPrimer = function showPrimer(id) {
        $location.path("/primers/" + id);
    };

    // Watch for changes on the search parameters and fire off a request.
    // The model is debounced.
    var search = function search() {
        $http({
            url: "/primers",
            method: "GET",
            params: {
                code: $scope.searchCode,
                name: $scope.searchName,
                sequence: $scope.searchSequence
            }
        }).success(function searchSuccess(response) {
            $scope.page = 1;
            $scope.endOfResults = response.length < 100;
            $scope.primers = response;
        });
    };
    $scope.$watchGroup(["searchCode", "searchName", "searchSequence"], search);

    $scope.loadMore = function loadMore() {
        $http({
            url: "/primers",
            method: "GET",
            params: {
                code: $scope.searchCode,
                name: $scope.searchName,
                sequence: $scope.searchSequence,
                page: $scope.page + 1
            }
        }).success(function searchSuccess(response) {
            $scope.page++;
            $scope.endOfResults = response.length < 100;
            $scope.primers = $scope.primers.concat(response);
        });
    };
});

primers.controller("PrimerDetailController", function($scope, $routeParams, $location, Primer) {
    primer = Primer.get({ id: $routeParams.id }, function() {
        $scope.primer = primer;
    });

    $scope.save = function() {
        $scope.primer.$update({}, function success() {
            $location.path("/primers");
        }, function error(res) {
            $scope.errors = res.data;
        });
    };

    $scope.delete = function() {
        $scope.primer.$delete();
    }
});

primers.controller("NewPrimerController", function($scope, $location, Primer) {
    $scope.primer = new Primer();

    $scope.save = function() {
        $scope.primer.$save({}, function success() {
            $location.path("/primers");
        }, function error(res) {
            $scope.errors = res.data;
        });
    };
});