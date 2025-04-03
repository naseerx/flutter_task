import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task/api_resources/api_repos_imp/category_repo_impl.dart';
import 'package:task/api_resources/api_services/api_response.dart';
import 'package:task/models/category_model.dart';
import 'package:task/models/product_model.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryProvider() {
    searchController.addListener(() {
      searchProducts(searchController.text);
    });
    categorySearchController.addListener(() {
      searchCategory(categorySearchController.text);
    });
  }

  final TextEditingController categorySearchController =
      TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final CategoryRepoImpl _categoryRepoImpl = CategoryRepoImpl();

  List<CategoryModel> _allCategories = [];
  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ProductModel> _allProducts = [];
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isProductsLoading = false;
  bool get isProductsLoading => _isProductsLoading;

  Future<void> fetchCategories(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      ApiResponse response = await _categoryRepoImpl.fetchAllCategories();

      if (response.status == Status.completed) {
        final decodedData = jsonDecode(response.data);

        if (decodedData != null && decodedData is List) {
          _allCategories = decodedData
              .map((categoryData) => CategoryModel.fromJson(categoryData))
              .toList()
              .cast<CategoryModel>();

          _categories = List.from(_allCategories);
        } else {
          print('No categories found');
        }
      } else {
        print('Failed to fetch categories');
      }
    } catch (e) {
      print("Error: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchProductsByCategory(
      BuildContext context, String categoryName) async {
    _isProductsLoading = true;
    notifyListeners();

    try {
      ApiResponse response =
          await _categoryRepoImpl.productsByCategory(categoryName);

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
      _isProductsLoading = false;
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

  void searchCategory(String query) {
    if (query.isEmpty) {
      _categories = List.from(_allCategories);
    } else {
      _categories = _allCategories
          .where((category) =>
              category.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
