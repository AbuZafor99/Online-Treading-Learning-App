import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CalendarEvent {
  final String title;
  final String time;
  final String coach;
  final String avatarUrl;
  CalendarEvent({
    required this.title,
    required this.time,
    required this.coach,
    required this.avatarUrl,
  });
}

class CalendarController extends GetxController {
  final selectedDate = DateTime.now().obs;
  final currentMonth = DateTime.now().obs;
  final dayScroll = ScrollController().obs;

  List<DateTime> get daysInMonth {
    final first = DateTime(
      currentMonth.value.year,
      currentMonth.value.month,
      1,
    );
    final nextMonth = DateTime(
      currentMonth.value.year,
      currentMonth.value.month + 1,
      1,
    );
    final last = nextMonth.subtract(const Duration(days: 1));
    return List.generate(
      last.day,
      (i) => DateTime(first.year, first.month, i + 1),
    );
  }

  final events = <DateTime, List<CalendarEvent>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _seedMock();
  }

  @override
  void onReady() {
    super.onReady();
    _scrollToSelected();
  }

  void _seedMock() {
    final today = DateTime.now();
    final key = DateTime(today.year, today.month, today.day);
    events[key] = [
      CalendarEvent(
        title: 'Freshman Class Live Q&A',
        time: 'Monday, 4:00 PM',
        coach: 'Coach Dianne Russell',
        avatarUrl: 'https://i.pravatar.cc/100?img=67',
      ),
      CalendarEvent(
        title: 'CPI Release',
        time: 'Monday, 4:00 PM',
        coach: 'Coach Dianne Russell',
        avatarUrl: 'https://i.pravatar.cc/100?img=12',
      ),
      CalendarEvent(
        title: 'Gold Trade Setup',
        time: 'Monday, 4:00 PM',
        coach: 'Coach Dianne Russell',
        avatarUrl: 'https://i.pravatar.cc/100?img=5',
      ),
      CalendarEvent(
        title: 'OFW Hub Webinar',
        time: 'Monday, 4:00 PM',
        coach: 'Coach Dianne Russell',
        avatarUrl: 'https://i.pravatar.cc/100?img=49',
      ),
    ];
  }

  List<CalendarEvent> eventsFor(DateTime date) {
    final key = DateTime(date.year, date.month, date.day);
    return events[key] ?? [];
  }

  void goPrevMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month - 1,
      1,
    );
  }

  void goNextMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month + 1,
      1,
    );
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    _scrollToSelected();
  }

  void _scrollToSelected() {
    final controllerRef = dayScroll.value;
    final index = selectedDate.value.day - 1.2;
    final itemExtent = 64.0 + 7.0;
    final offset = (index * itemExtent) - 16;
    if (controllerRef.hasClients) {
      controllerRef.animateTo(
        offset.clamp(0, controllerRef.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
