import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:get/get.dart';

import '../../controller/calender_controller.dart';
import '../widgets/day_clip_widget.dart';
import '../widgets/event_card_widget.dart';
import '../widgets/month_year.dart';

class CalendarScreen extends GetView<CalendarController> {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CalendarController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calendar',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.appBarTitle,
          ),
        ),
      ),
      body: Obx(() {
        final month = controller.currentMonth.value;
        final days = controller.daysInMonth;

        return ListView(
          padding: const EdgeInsets.symmetric(vertical: 12),

          children: [
            MonthYear(
              month: month,
              onPrevMonth: controller.goPrevMonth,
              onNextMonth: controller.goNextMonth,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 90,
              child: ListView.separated(
                controller: controller.dayScroll.value,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: days.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final date = days[index];
                  final selected = _isSameDay(
                    date,
                    controller.selectedDate.value,
                  );

                  return DayChipWidget(
                    date: date,
                    selected: selected,
                    onTap: () => controller.selectDate(date),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildEventsList(controller),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildEventsList(CalendarController controller) {
    final items = controller.eventsFor(controller.selectedDate.value);

    if (items.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 48),
        alignment: Alignment.center,
        child: const Text('No events', style: TextStyle(color: Colors.black54)),
      );
    }

    return Column(
      children: items.map((e) => EventCardWidget(event: e)).toList(),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
