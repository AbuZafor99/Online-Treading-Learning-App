import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  final bool checked;
  final Color? color;

  const CustomRadio({super.key, required this.checked, this.color});

  @override
  Widget build(BuildContext context) {
    final borderColor =
        color ?? (checked ? Colors.grey : Colors.grey.withOpacity(0.5));
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: checked
          ? Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: borderColor,
                ),
              ),
            )
          : null,
    );
  }
}
