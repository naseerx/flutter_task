class AppApiPaths {
  /// API URLs
  static const String baseUrl = 'https://dummyjson.com/products';
  static const String productsApi = '$baseUrl?limit=100';
  String singleProductApi(int productId) => '$baseUrl/$productId';
  static const String categoriesApi = '$baseUrl/categories';
  static const String categoriesProductsApi = '$baseUrl/category/';
}
