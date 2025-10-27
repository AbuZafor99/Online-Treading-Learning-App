import 'package:flutter/material.dart';

class TitleTextWithVerifiedIcon extends StatelessWidget {
  const TitleTextWithVerifiedIcon({
    super.key,
    required this.title,
    this.textColor,
    this.iconColor = const Color(0xFF00A86B),
    this.textAlign = TextAlign.center,
  });

  final String title;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            'Trading Risk: I understand that trading in financial markets involves significant risk and may result in the loss of capital. No individual or entity has guaranteed profits, and I take full responsibility for my trading decisions.',
          ),
        ),
        const SizedBox(width: 15),
        Icon(Icon(Icons.check_circle) as IconData?, color: iconColor, size: 15),
      ],
    );
  }
}
