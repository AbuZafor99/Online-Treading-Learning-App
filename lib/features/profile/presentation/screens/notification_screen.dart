import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool signalAlerts = true;
  bool eventReminders = false;
  bool promoAnnouncements = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notification Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // 1st switch
            Theme(
              data: Theme.of(context).copyWith(
                switchTheme: SwitchThemeData(
                  thumbIcon: MaterialStateProperty.resolveWith<Icon?>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Icon(
                        Icons.circle,
                        size: 30,
                        color: Color(0xFF1A3E74),
                      ); // Active thumb size
                    }
                    return const Icon(
                      Icons.circle,
                      size: 30,
                      color: Color(0xFFE0E0E0),
                    ); // Inactive thumb size
                  }),

                  trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    if (states.contains(MaterialState.selected)) {
                      return Color(0xFFEFC227); // when active
                    }
                    return Color(0xFFA8A8A8); // when inactive
                  }),
                ),
              ),

              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Signal alerts from specific coaches only"),
                value: signalAlerts,
                visualDensity: VisualDensity.compact,
                activeTrackColor: Color(0xFFEFC227),
                inactiveTrackColor: Color(0xFFA8A8A8),

                onChanged: (value) {
                  setState(() {
                    signalAlerts = value;
                  });
                },
              ),
            ),

            // 2nd switch
            Theme(
              data: Theme.of(context).copyWith(
                switchTheme: SwitchThemeData(
                  thumbIcon: MaterialStateProperty.resolveWith<Icon?>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Icon(
                        Icons.circle,
                        size: 30,
                        color: Color(0xFF1A3E74),
                      ); // Active thumb size
                    }
                    return const Icon(
                      Icons.circle,
                      size: 30,
                      color: Color(0xFFE0E0E0),
                    ); // Inactive thumb size
                  }),

                  trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    if (states.contains(MaterialState.selected)) {
                      return Color(0xFFEFC227); // when active
                    }
                    return Color(0xFFA8A8A8); // when inactive
                  }),
                ),
              ),

              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Event/class reminders"),
                value: eventReminders,
                activeTrackColor: Color(0xFFEFC227),
                inactiveTrackColor: Color(0xFFA8A8A8),

                onChanged: (value) {
                  setState(() {
                    eventReminders = value;
                  });
                },
              ),
            ),

            // 3rd switch
            Theme(
              data: Theme.of(context).copyWith(
                switchTheme: SwitchThemeData(
                  thumbIcon: MaterialStateProperty.resolveWith<Icon?>((states) {
                    if (states.contains(MaterialState.selected)) {
                      return const Icon(
                        Icons.circle,
                        size: 30,
                        color: Color(0xFF1A3E74),
                      ); // Active thumb size
                    }
                    return const Icon(
                      Icons.circle,
                      size: 30,
                      color: Color(0xFFE0E0E0),
                    ); // Inactive thumb size
                  }),

                  trackOutlineColor: MaterialStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    if (states.contains(MaterialState.selected)) {
                      return Color(0xFFEFC227); // when active
                    }
                    return Color(0xFFA8A8A8); // when inactive
                  }),
                ),
              ),

              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Promo/discounts or announcements"),
                value: promoAnnouncements,
                activeTrackColor: Color(0xFFEFC227),
                inactiveTrackColor: Color(0xFFA8A8A8),

                onChanged: (value) {
                  setState(() {
                    promoAnnouncements = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
