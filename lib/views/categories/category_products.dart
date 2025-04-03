import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task/providers/category_provider.dart';
import 'package:task/constants/constants.dart';
import 'package:task/routes/app_pages.dart';
import 'package:task/views/common/common_textfield.dart';
import 'package:task/views/common/product_card.dart';

class CategoryProducts extends StatefulWidget {
  const CategoryProducts({super.key});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  late String categoryName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args != null && args is String) {
        categoryName = args;
        print('category name before passing is $categoryName');
        final provider = Provider.of<CategoryProvider>(context, listen: false);
        provider.fetchProductsByCategory(context, categoryName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tabProducts,
          style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          if (provider.isProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CustomTextField(
                  controller: provider.searchController,
                  hintText: search,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.search),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${provider.products.length.toString()} $resultsFound',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
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
