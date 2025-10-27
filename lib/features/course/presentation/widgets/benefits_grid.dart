// lib/features/courses/widgets/benefits_grid.dart

import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';

class BenefitsGrid extends StatelessWidget {
  final List<String> benefitsImages;
  final List<String> benefits;

  const BenefitsGrid({
    super.key,
    required this.benefitsImages,
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: benefitsImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 80,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),

      itemBuilder: (ctx, i) => Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              benefitsImages[i],
              fit: BoxFit.cover,
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 6),
            Text(
              benefits[i],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
