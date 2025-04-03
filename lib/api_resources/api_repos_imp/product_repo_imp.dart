import 'package:http/http.dart';
import 'package:task/api_resources/api_repos_abstract/product_repo.dart';
import 'package:task/api_resources/api_services/api_response.dart';
import 'package:task/api_resources/api_services/handling_response.dart';
import 'package:task/constants/api_urls.dart';

class ProductRepoImp extends ProductRepo {
  @override
  Future<ApiResponse> fetchAllProducts() async {
    try {
      Response res = await apiServices.get(AppApiPaths.productsApi);

      print('API Response Body: ${res.body}');
      print('API Response Status Code: ${res.statusCode}');

      if (res.statusCode == 200) {
        return ApiResponse.completed(res.body);
      } else {
        return HandlingResponse.returnResponse(res);
      }
    } catch (e) {
      print('Exception: $e');
      ApiResponse response = HandlingResponse.returnException(
        e,
      );
      return response;
    }
  }
}
