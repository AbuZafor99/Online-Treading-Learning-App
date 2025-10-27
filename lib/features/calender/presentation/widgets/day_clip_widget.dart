import 'package:flutter/material.dart';

class DayChipWidget extends StatelessWidget {
  final DateTime date;
  final bool selected;
  final VoidCallback onTap;

  const DayChipWidget({
    super.key,
    required this.date,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final text = TextStyle(
      color: selected ? Color(0XFF1A3E74) : Color(0xffEFC227),
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: MediaQuery.of(context).size.width / 7,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFFFD54F) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? const Color(0xFFFFD54F) : const Color(0xFFE4C984),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_twoDigits(date.day), style: text),
            const SizedBox(height: 2),
            Text(
              _weekday(date.weekday),
              style: text.copyWith(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  String _weekday(int w) =>
      const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][w - 1];
}
