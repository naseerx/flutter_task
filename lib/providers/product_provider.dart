import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:task/api_resources/api_repos_imp/product_repo_imp.dart';
import 'package:task/api_resources/api_services/api_response.dart';
import 'package:task/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final ProductRepoImp _productRepoImp = ProductRepoImp();

  List<ProductModel> _allProducts = [];
  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      ApiResponse response = await _productRepoImp.fetchAllProducts();

      if (response.status == Status.completed) {
        final decodedData = jsonDecode(response.data);

        if (decodedData != null && decodedData['products'] != null) {
          _allProducts = (decodedData['products'] as List)
              .map((productData) => ProductModel.fromJson(productData))
              .toList();

          _products = List.from(_allProducts);
        } else {
          print('No data found');
        }
      } else {
        print('Failed to fetch data');
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      _products = List.from(_allProducts);
    } else {
      _products = _allProducts
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
