import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';

class StarRating extends StatelessWidget {
  final double rating; // Fraction rating like 3.5, 4.2
  final double size;

  const StarRating({super.key, required this.rating, this.size = 30});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 1; i <= 5; i++)
          Icon(
            // Decide which icon to show
            rating >= i
                ? Icons
                      .star // full star
                : (rating >= i - 0.5
                      ? Icons.star_half
                      : Icons.star_border), // half or empty
            color: AppColors.starRatingColor,
            size: size,
          ),
      ],
    );
  }
}
