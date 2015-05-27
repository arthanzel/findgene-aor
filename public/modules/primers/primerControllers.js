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

primers.controller("PrimerListController", function($scope, Primer) {
    var data = Primer.query(function() {
        $scope.primers = data;
    });
});

primers.controller("PrimerDetailController", function($scope, $routeParams, $location, Primer) {
    primer = Primer.get({ id: $routeParams.id }, function() {
        $scope.primer = primer;
    });

    $scope.save = function() {
        $scope.primer.$update({}, function() {
            $location.path("/primers");
        });
    };

    $scope.delete = function() {
        $scope.primer.$delete();
    }
});

primers.controller("NewPrimerController", function($scope, $location, Primer) {
    $scope.primer = new Primer();

    $scope.save = function() {
        $scope.primer.$save({}, function() {
            $location.path("/primers");
        });
    };
});