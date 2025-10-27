import 'package:flutter/material.dart';
import '../common/images/images.dart';

class TSocialButton extends StatelessWidget {
  const TSocialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DifferentLoginApproach(
          text: 'Continue With Google',
          image: ImagesString.googleLogo,
        ),

        SizedBox(height: 13),

        DifferentLoginApproach(
          text: 'Continue With Apple',
          image: ImagesString.appleLogo,
        ),
      ],
    );
  }
}

class DifferentLoginApproach extends StatelessWidget {
  const DifferentLoginApproach({
    super.key,
    required this.text,
    required this.image,
  });

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(width: 24, height: 24, image: AssetImage(image)),
            SizedBox(width: 6),
            Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
