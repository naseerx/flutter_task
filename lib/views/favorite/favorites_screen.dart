import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task/constants/constants.dart';
import 'package:task/models/product_model.dart';
import 'package:task/providers/favorite_provider.dart';
import 'package:task/routes/app_pages.dart';
import 'package:task/views/common/favorite_product_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel> filteredFavorites = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<FavoriteProvider>(context, listen: false);
      setState(() {
        filteredFavorites = provider.favorites;
      });
    });
  }

  void filterFavorites(String query) {
    final provider = Provider.of<FavoriteProvider>(context, listen: false);
    setState(() {
      filteredFavorites = provider.favorites
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Favourites',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: searchController,
                  onChanged: filterFavorites,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: search,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${filteredFavorites.length} $resultsFound',
                  style: TextStyle(fontSize: 14.sp),
                ),
                const SizedBox(height: 10),
                // Favorites List
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredFavorites.length,
                    itemBuilder: (context, index) {
                      final product = filteredFavorites[index];

                      return FavoriteProductCard(
                        product: product,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.productDetailsScreen,
                            arguments: product,
                          );
                        },
                        onIconTap: () {
                          provider.removeFromFavorites(product);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
