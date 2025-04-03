import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/constants/assets.dart';
import 'package:task/routes/app_pages.dart';
import 'package:task/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(splashImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(height: 70.h),
            Text(
              myStore,
              style: TextStyle(
                fontSize: 50.sp,
                fontFamily: 'Playfair Display',
                color: Colors.black,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                Text(
                  welcomeMessage,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Playfair Display',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontFamily: 'Playfair Display',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 120.h),
          ],
        ),
      ),
    );
  }
}
