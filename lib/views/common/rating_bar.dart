import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RatingBarWidget extends StatelessWidget {
  final double rating;
  final bool textLater;

  const RatingBarWidget(
      {super.key, required this.rating, required this.textLater});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      children: [
        ...List.generate(fullStars,
            (index) => const Icon(Icons.star, color: Colors.amber, size: 16)),
        if (hasHalfStar)
          const Icon(Icons.star_half, color: Colors.amber, size: 16),
        ...List.generate(
            emptyStars,
            (index) =>
                const Icon(Icons.star_border, color: Colors.amber, size: 16)),
        const SizedBox(width: 4),
        !textLater
            ? const SizedBox()
            : Text(
                rating.toStringAsFixed(1),
                style: TextStyle(fontSize: 12.sp),
              ),
      ],
    );
  }
}
