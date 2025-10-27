import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text("🏠 Home Page")),
    Center(child: Text("👥 Community Page")),
    Center(child: Text("📚 Courses Page")),
    Center(child: Text("👤 Profile Page")),
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavTapped,
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  final List<String> _titles = const [
    "Home",
    "Community",
    "Courses",
    "Profile",
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.group,
    Icons.menu_book,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Container(
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_titles.length, (index) {
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () => onItemTapped(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.buttonColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(_icons[index], color: Colors.blue[900]),
                        if (isSelected)
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              _titles[index],
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
