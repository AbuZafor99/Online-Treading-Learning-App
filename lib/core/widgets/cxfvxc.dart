import 'package:flutter/material.dart';

class CongratulationsDialog extends StatelessWidget {
  final String courseName;
  final String imagePath;
  final VoidCallback onContinue;

  const CongratulationsDialog({
    Key? key,
    required this.courseName,
    required this.imagePath,
    required this.onContinue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image (replace with correct asset path or network image)
            Image.asset(imagePath, width: 160, fit: BoxFit.contain),
            const SizedBox(height: 16),

            // Title
            Text(
              'Congratulations',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
                letterSpacing: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Subtitle
            Text(
              "Great to have you!\nYou’re now officially part of the",
              style: TextStyle(fontSize: 15, color: Colors.black87),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            // Highlighted Course Name
            Text(
              '“$courseName”',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFC107), // yellow highlight
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1D3557),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
