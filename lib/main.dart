import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task/constants/app_colors.dart';
import 'package:task/di/di.dart';
import 'package:task/providers/category_provider.dart';
import 'package:task/providers/favorite_provider.dart';
import 'package:task/providers/product_provider.dart';
import 'package:task/routes/app_pages.dart';
import 'package:task/constants/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DI.initDI();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => ProductProvider()..fetchProducts(context)),
            ChangeNotifierProvider(
                create: (_) => CategoryProvider()..fetchCategories(context)),
            ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ],
          child: MaterialApp(
            title: myStore,
            theme: ThemeData(
                colorScheme:
                    ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
                useMaterial3: true,
                scaffoldBackgroundColor: AppColors.white,
                appBarTheme: const AppBarTheme(
                    backgroundColor: AppColors.scaffoldColor,
                    centerTitle: true),
                fontFamily: 'Poppins'),
            initialRoute: AppPages.initialRoute,
            onGenerateRoute: AppPages.generateRoute,
          ),
        );
      },
    );
  }
}
