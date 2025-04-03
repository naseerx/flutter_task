import '../api_services/api_response.dart';
import '../base_repo/base.dart';

abstract class CategoryRepo extends Base {
  Future<ApiResponse> fetchAllCategories();
  Future<ApiResponse> productsByCategory(String productName);
}
