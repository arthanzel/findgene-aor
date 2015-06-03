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
    authStore.clearCredentials();

    $scope.submit = function() {
        // $http will automatically set a request header with credentials from authStore.
        // This logic lives in httpConfig.js.
        authStore.setCredentials($scope.username, $scope.password);

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
    authStore.clearCredentials();

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
    },
    clearCredentials: function() {
        sessionStorage.removeItem("username");
        sessionStorage.removeItem("password");
    }
});