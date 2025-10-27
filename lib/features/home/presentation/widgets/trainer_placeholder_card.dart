import 'package:flutter/material.dart';

class TrainerPlaceholderCard extends StatelessWidget {
  const TrainerPlaceholderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          style: BorderStyle.solid,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Placeholder Avatar
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade200,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Icon(
                Icons.person_outline,
                color: Colors.grey.shade400,
                size: 30,
              ),
            ),

            const SizedBox(width: 12),

            // Placeholder Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placeholder Name
                  Container(
                    height: 16,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Placeholder Role
                  Container(
                    height: 12,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Placeholder Rating
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          Icons.star_border,
                          size: 14,
                          color: Colors.grey.shade300,
                        );
                      }),
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
