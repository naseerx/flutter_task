import '../api_services/api_response.dart';
import '../base_repo/base.dart';

abstract class ProductRepo extends Base {
  Future<ApiResponse> fetchAllProducts();
}
