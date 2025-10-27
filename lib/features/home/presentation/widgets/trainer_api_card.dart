import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import '../../models/trainer_api_model.dart';

class TrainerApiCard extends StatelessWidget {
  final TrainerApiModel trainer;

  const TrainerApiCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            //* <--- Trainer Avatar --->
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ClipOval(
                child: trainer.displayAvatarUrl.isNotEmpty
                    ? Image.network(
                        trainer.displayAvatarUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/images/avatar.png',
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(
                        'assets/images/avatar.png',
                        fit: BoxFit.cover,
                      ),
              ),
            ),

            const SizedBox(width: 12),

            //* <--- Trainer Details --->
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        trainer.displayName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.titleTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      if (trainer.verificationInfo.verified) ...[
                        const SizedBox(width: 6),
                        Icon(
                          Icons.verified,
                          size: 14,
                          color: Colors.blue.shade600,
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 4),

                  //* <--- Role and verification --->
                  Row(
                    children: [
                      Text(
                        trainer.role.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.hintText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Text(
                        '  •  ${trainer.successRate.toStringAsFixed(0)}% Success',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.hintText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  //* <--- Rating --->
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < trainer.overallRating.round()
                              ? Icons.star
                              : Icons.star_border,
                          size: 14,
                          color: Colors.amber,
                        );
                      }),
                      const SizedBox(width: 6),
                      Text(
                        '${trainer.overallRating.toStringAsFixed(1)} / 5.0',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.hintText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
