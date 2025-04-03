import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/constants/assets.dart';
import 'package:task/constants/constants.dart';
import 'package:task/views/favorite/favorites_screen.dart';
import 'package:task/views/products/products_screen.dart';
import 'package:task/views/categories/categories_screen.dart';
import 'package:task/views/setting/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(productIcon)), label: tabProducts),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(categoryIcon)), label: tabCategories),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(favoriteIcon)), label: tabFavorites),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage(userIcon)), label: tabUser),
        ],
      ),
    );
  }
}
