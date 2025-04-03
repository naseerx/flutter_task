import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task/providers/product_provider.dart';
import 'package:task/constants/constants.dart';
import 'package:task/routes/app_pages.dart';
import 'package:task/views/common/common_textfield.dart';
import 'package:task/views/common/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductProvider>(context, listen: false);
    provider.searchController.addListener(() {
      provider.searchProducts(provider.searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          tabProducts,
          style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CustomTextField(
                  controller: provider.searchController,
                  hintText: search,
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.search),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${provider.products.length} $resultsFound',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      final product = provider.products[index];
                      return ProductCard(
                        imageUrl: product.thumbnail,
                        title: product.title,
                        rating: product.rating,
                        brand: product.brand,
                        category: product.category,
                        price: product.price,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.productDetailsScreen,
                            arguments: product,
                          );
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
