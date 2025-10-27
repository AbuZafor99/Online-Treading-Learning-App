import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text('About App')),

      body: SafeArea(
        child: CustomText(
          'Legendary Trading Academy is an institution committed to help filipinos meet their financial freedom through financial education. We believe that knowledge is the cornerstone of empowerment, and our mission is to equip our students with the skills and insights needed to navigate the complex world of trading and finance. Our curriculum is designed to be accessible and practical, ensuring that everyone, regardless of their background, can benefit from our courses. Through expert-led workshops, interactive sessions, and personalized mentoring, we strive to inspire confidence and foster a community of informed and proactive individuals ready to take control of their financial futures.',
          style: TextStyle(
            color: AppColors.emailIconColor,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
