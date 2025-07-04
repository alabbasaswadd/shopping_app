String baseUrl = "http://multi-vendor-api.runasp.net";
const String signUp = "/multi-vendor-api/Account/customer/register";
const String login = "/multi-vendor-api/Account/customer/login";
const String getCategoyries = "/multi-vendor-api/Category";
const String getShops = "/multi-vendor-api/Shop";
const String getAllProducts = "/multi-vendor-api/Product";
const String addProductToTheCart = "/multi-vendor-api/ShoppingCart";
const String getCart = "/multi-vendor-api/ShoppingCart";

String getUserRoute(String id) => "/multi-vendor-api/Customer/$id";
String getProductsByShopId(String id) => "/multi-vendor-api/Product/$id";
String updateUserRoute(String id) => "/multi-vendor-api/Customer/$id";
String deleteUserRoute(String id) => "/multi-vendor-api/Customer/$id";
String clearCart(String cartId) =>
    "/multi-vendor-api/ShoppingCart/clearcart/$cartId";
String deleteProductFromCart(String productId) =>
    "/multi-vendor-api/ShoppingCart/removeitem/$productId";
