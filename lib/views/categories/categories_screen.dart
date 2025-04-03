import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task/constants/app_colors.dart';
import 'package:task/constants/constants.dart';
import 'package:task/providers/category_provider.dart';
import 'package:task/routes/app_pages.dart';
import 'package:task/views/common/common_textfield.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    provider.categorySearchController.addListener(() {
      provider.searchCategory(provider.categorySearchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tabCategories,
          style: TextStyle(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                CustomTextField(
                  controller: provider.categorySearchController,
                  hintText: search,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.search),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${provider.categories.length.toString()} $resultsFound',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 2 columns
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: provider.categories.length,
                      itemBuilder: (context, index) {
                        final categories = provider.categories[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.categoryProducts,
                              arguments: categories.name,
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.primaryColor),
                            // decoration: BoxDecoration(
                            // image: DecorationImage(
                            //     image: NetworkImage(categories.url))),
                            child: Center(
                              child: Text(
                                categories.name,
                                style: const TextStyle(color: AppColors.white),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
