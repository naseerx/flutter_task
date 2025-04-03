import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:task/views/categories/category_products.dart';
import 'package:task/views/home/home_screen.dart';
import 'package:task/views/products/product_details_screen.dart';
import 'package:task/views/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String homeScreen = '/homeScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String categoryProducts = '/categoryProducts';
}

class AppPages {
  AppPages._();

  static const initialRoute = Routes.splashScreen;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return _buildAnimatedRoute(const SplashScreen(), settings);

      case Routes.homeScreen:
        return _buildAnimatedRoute(const HomeScreen(), settings);

      case Routes.productDetailsScreen:
        return _buildAnimatedRoute(const ProductDetailsScreen(), settings);

      case Routes.categoryProducts:
        return _buildAnimatedRoute(const CategoryProducts(), settings);

      // case Routes.allCards:
      //   return _buildAnimatedRoute(
      //       AllCards(params: settings.arguments as CardDataParams), settings);
      //

      default:
        return _buildAnimatedRoute(
          Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
          settings,
        );
    }
  }

  static PageRouteBuilder _buildAnimatedRoute(
      Widget page, RouteSettings settings) {
    print("Navigating to: ${settings.name}");

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) {
        print("PageBuilder called for ${settings.name}");
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (kDebugMode) {
          print("Transition started for ${settings.name}");
        }

        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        animation.addStatusListener((status) {
          print("Animation status for ${settings.name}: $status");
        });

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
