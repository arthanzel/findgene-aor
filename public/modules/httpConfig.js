angular.module("fg-http-config", ["fg-authStore"])
.factory("authInterceptor", function($q, $location, authStore) {
    return {
        "request": function(config) {
            if (authStore.hasCredentials()) {
                config.headers["X-FindGene-Auth"] = authStore.credentials();
            }

            console.log("REQUEST");
            console.log(config);
            return config;
        },

        "responseError": function(response) {
            if (response.status == 401) {
                $location.path("/login");
                return response;
            }
            
            return response;
        }
    };
})
.config(function($httpProvider) {
    $httpProvider.interceptors.push("authInterceptor");
});