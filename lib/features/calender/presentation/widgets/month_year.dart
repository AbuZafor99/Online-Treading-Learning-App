import 'package:flutter/material.dart';

class MonthYear extends StatelessWidget {
  final DateTime month;
  final VoidCallback onPrevMonth;
  final VoidCallback onNextMonth;

  const MonthYear({
    super.key,
    required this.month,
    required this.onPrevMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onPrevMonth,
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            _monthYear(month),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff1A3E74),
            ),
          ),
          IconButton(
            onPressed: onNextMonth,
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }

  String _monthYear(DateTime d) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[d.month - 1]} ${d.year}';
  }
}
