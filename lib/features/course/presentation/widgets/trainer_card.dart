// lib/features/courses/widgets/trainer_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';

class TrainerCard extends StatelessWidget {
  final String name;
  final String image;
  final String stats;

  const TrainerCard({
    super.key,
    required this.name,
    required this.image,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      color: AppColors.cardBackgroundColor,
      child: ListTile(
        leading: CircleAvatar(backgroundImage: AssetImage(image)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(stats),
      ),
    );
  }
}
