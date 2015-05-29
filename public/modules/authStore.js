angular.module("fg-authStore", [])
.value("authStore", {
    username: "", password: "",
    hasCredentials: function() { return this.username && this.password },
    credentials: function() { return this.username + "/" + this.password }
});