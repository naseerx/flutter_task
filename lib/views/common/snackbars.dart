import 'package:flutter/material.dart';
import 'package:task/constants/app_colors.dart';

showSnackBar(BuildContext context, String message,
    {Color bgColor = AppColors.primaryColor,
    bool isError = false,
    Duration? duration}) {
  bgColor = isError ? AppColors.errorColor : bgColor;

  duration ??= const Duration(seconds: 2);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: AppColors.white),
      ),
      backgroundColor: bgColor,
      duration: duration,
    ),
  );
}

showGuestSnackBar(BuildContext context, String message) {
  showSnackBar(context, message);
}
