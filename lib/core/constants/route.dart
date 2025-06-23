String baseUrl = "http://multi-vendor-api.runasp.net";
const String signUp = "/multi-vendor-api/Account/customer/register";
const String login = "/multi-vendor-api/Account/customer/login";
String getUserRoute(String id) => "/multi-vendor-api/Customer/$id";
String updateUserRoute(String id) => "/multi-vendor-api/Customer/$id";
String deleteUserRoute(String id) => "/multi-vendor-api/Customer/$id";
