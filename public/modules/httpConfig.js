angular.module("fg-http-config", [])
.factory("authInterceptor", function($q, $location) {
    return {
        "request": function(config) {
            config.headers["X-FindGene-Auth"] = "test_user/my_password";

            console.log("REQUEST");
            console.log(config);
            return config;
        },

        "response": function(response) {
            console.log("RESPONSE");
            console.log(response);
            return response;
        },

        "responseError": function(response) {
            if (response.status == 401) {
                $location.path("/login");
                return response;
            }

            console.log("REJECTION");
            console.log(response);
            return response;
        }
    };
})
.config(function($httpProvider) {
    $httpProvider.interceptors.push("authInterceptor");
});