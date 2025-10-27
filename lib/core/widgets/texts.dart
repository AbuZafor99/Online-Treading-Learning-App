import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(this.text, {super.key, this.style});
  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style ?? Theme.of(context).textTheme.bodyLarge);
  }
}
