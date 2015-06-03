angular.module("fg-http-config", ["fg-authStore"])
.factory("authInterceptor", function($q, $location, authStore) {
    return {
        "request": function(config) {
            if (authStore.hasCredentials()) {
                config.headers["X-FindGene-Auth"] = authStore.credentials();
            }
            return config;
        },

        "responseError": function(response) {
            if (response.status == 401) {
                $location.path("/login");
                return response;
            }

            return $q.reject(response);
        }
    };
})
.config(function($httpProvider) {
    $httpProvider.interceptors.push("authInterceptor");
});