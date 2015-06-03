angular.module("fg-authStore", ["ngRoute"])
.config(function($routeProvider) {
    $routeProvider
        .when("/login", {
            controller: "LoginController",
            templateUrl: "modules/auth/login.html"
        })
        .when("/logout", {
            controller: "LogoutController",
            template: ""
        });
})
.controller("LoginController", function($scope, $location, $http, authStore) {
    $scope.username = "";
    $scope.password = "";
    $scope.submit = function() {
        // $http will set a request header with credentials in authStore.
        authStore.setCredentials($scope.username, $scope.password);
        console.log(authStore.credentials());

        $http.get("/auth")
            .success(function() {
                $location.path("/primers");
            })
            .error(function() {
                $scope.password = "";
                $scope.message = "Incorrect username or password.";
            });
    };
})
.controller("LogoutController", function ($location, authStore) {
    console.log("logout");
    authStore.username = "";
    authStore.password = "";

    $location.path("/login");
})
.value("authStore", {
    username: "", password: "",
    credentials: function() {
        return sessionStorage.getItem("username") +
            "/" +
            sessionStorage.getItem("password");
    },
    hasCredentials: function() {
        return sessionStorage.getItem("username")  && sessionStorage.getItem("password");
    },
    setCredentials: function(u, p) {
        sessionStorage.setItem("username", u);
        sessionStorage.setItem("password", p);
    }
});