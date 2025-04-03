import 'package:flutter/cupertino.dart';
import 'package:task/models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<ProductModel> _favorites = [];
  List<ProductModel> _filteredFavorites = [];

  List<ProductModel> get favorites => _favorites;
  List<ProductModel> get filteredFavorites => _filteredFavorites;

  void addToFavorites(ProductModel product) {
    if (!_favorites.contains(product)) {
      _favorites.add(product);
      notifyListeners();
    }
  }

  void filterFavorites(String query) {
    if (query.isEmpty) {
      _filteredFavorites = List.from(_favorites);
    } else {
      _filteredFavorites = _favorites
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void removeFromFavorites(ProductModel product) {
    if (_favorites.contains(product)) {
      _favorites.remove(product);
      notifyListeners();
    }
  }

  bool isFavorite(ProductModel product) {
    return _favorites.contains(product);
  }
}
