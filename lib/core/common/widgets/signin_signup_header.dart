import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';

class TLoginHeader extends StatelessWidget {
  const TLoginHeader({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final String image;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///logo, title, subtitle
          Image(height: 150, image: AssetImage(image)),

          Center(
            child: CustomText(
              title,
              style: TextStyle(
                color: Color(0xFF1A3E74),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 20),

          Center(
            child: Text(
              subTitle,
              style: TextStyle(fontSize: 16, color: Color(0xFF4E4E4E)),
            ),
          ),
        ],
      ),
    );
  }
}
