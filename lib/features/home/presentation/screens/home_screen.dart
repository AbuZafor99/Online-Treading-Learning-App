import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/core/widgets/custom_bottom_navbar.dart';
import 'package:flutter_ladydenily/features/ai_analysis/presentation/screens/ai_analysis_screen.dart';
import 'package:flutter_ladydenily/features/community/presentation/screens/community_screen.dart';
import 'package:flutter_ladydenily/features/course/models/course.dart';
import 'package:flutter_ladydenily/features/course/presentation/controllers/course_controller.dart';
import 'package:flutter_ladydenily/features/course/presentation/screens/coure_details_screen.dart';
import 'package:flutter_ladydenily/features/course/presentation/screens/course_all_screen.dart';
import 'package:flutter_ladydenily/features/course/presentation/widgets/course_details_card.dart';
import 'package:flutter_ladydenily/features/home/presentation/controllers/trainer_controller.dart';
import 'package:flutter_ladydenily/features/home/presentation/screens/trainer_all_screen.dart';
import 'package:flutter_ladydenily/features/home/presentation/widgets/my_course_card.dart';
import 'package:flutter_ladydenily/features/home/presentation/widgets/trainer_api_card.dart';
import 'package:flutter_ladydenily/features/home/presentation/widgets/trainer_placeholder_card.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/controllers/marketplace_controller.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/screens/marketplace_all_screen.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/widgets/marketplace_api_card.dart';
import 'package:flutter_ladydenily/features/notification/presentation/screens/notification_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/profile_screen.dart';
import 'package:get/get.dart';

import '../../../calender/presentation/screens/calender_screen.dart';
import '../../../search/presentation/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeContent(),
      const CommunityScreen(),
      CourseAllScreen(),
      ProfileScreen(),
    ];
  }

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onNavTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  void _navigateToCoursesDetails(BuildContext context) {
    Get.to(() => CourseAllScreen());
  }

  void _navigateToCourseDetail(BuildContext context, Course course) {
    Get.to(() => CourseDetailsScreen(), arguments: course);
  }

  void _navgiateToAllMarketplace(BuildContext context) {
    Get.to(() => const MarketplaceAllScreen());
  }

  void _navigateToAllTrainers(BuildContext context) {
    Get.to(() => const TrainerAllScreen());
  }

  @override
  Widget build(BuildContext context) {
    final courseController = Get.find<CourseController>();
    final profileController = Get.find<ProfileController>();
    final trainerController = Get.find<TrainerController>();
    final marketplaceController = Get.find<MarketplaceController>();

    // Fetch profile if not already loaded
    if (profileController.userInfo.value == null) {
      profileController.fetchProfile();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Get.to(ProfileScreen()),
              child: Container(
                height: 48,
                width: 48,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                clipBehavior: Clip.antiAlias,
                child: Obx(() {
                  final avatarUrl =
                      profileController.userInfo.value?.avatar.url;
                  return avatarUrl != null && avatarUrl.isNotEmpty
                      ? Image.network(
                          avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback to asset on network error
                            return Image.asset(
                              "assets/images/avatar.png",
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Image.asset(
                          "assets/images/avatar.png",
                          fit: BoxFit.cover,
                        );
                }),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    final user = profileController.userInfo.value;
                    final name = user?.name ?? user?.username ?? 'User';
                    return Text(
                      'Hello, $name',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.titleTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                  Text(
                    profileController.userInfo.value?.address ??
                        'Unknown Location',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome),
            onPressed: () => Get.to(() => const AiAnalysisScreen()),
            tooltip: 'AI Analysis',
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () => Get.to(CalendarScreen()),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => Get.to(NotificationScreen()),
          ),
          const SizedBox(width: 16),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 4, bottom: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),

            _buildSectionTitle(
              'Courses',
              onViewAllTap: () => _navigateToCoursesDetails(context),
            ),
            Obx(
              () => courseController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : _buildHorizontalList(
                      courseController.courses
                          .map(
                            (c) => GestureDetector(
                              onTap: () => _navigateToCourseDetail(context, c),
                              child: SizedBox(
                                width: 270,
                                child: CourseDetailsCard(course: c),
                              ),
                            ),
                          )
                          .toList(),
                      height: 340,
                    ),
            ),

            _buildSectionTitle(
              'Top Trainer',
              onViewAllTap: () => _navigateToAllTrainers(context),
            ),
            Obx(() {
              if (trainerController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return _buildTopTrainersList(trainerController);
            }),

            _buildSectionTitle(
              'Marketplace',
              onViewAllTap: () => _navgiateToAllMarketplace(context),
            ),
            Obx(
              () => marketplaceController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : _buildHorizontalList(
                      marketplaceController.marketplaceItems
                          .map(
                            (m) => GestureDetector(
                              onTap: () =>
                                  Get.to(() => const MarketplaceAllScreen()),
                              child: SizedBox(
                                width: 200,
                                child: MarketplaceApiCard(item: m),
                              ),
                            ),
                          )
                          .toList(),
                      height: 280,
                    ),
            ),

            _buildSectionTitle('My Courses'),
            Obx(
              () => courseController.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : _buildVerticalList(
                      courseController.courses
                          .where(
                            //! isNotEmpty to isEmpty <<<< MUST CHANGE LATER >>>>
                            (c) => c.enrolled.isEmpty,
                          )
                          .map(
                            (c) => GestureDetector(
                              onTap: () => _navigateToCourseDetail(context, c),
                              child: MyCourseCard(course: c),
                            ),
                          )
                          .toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTrainersList(TrainerController trainerController) {
    final trainers = trainerController.topTrainers.take(3).toList();
    final List<Widget> trainerWidgets = [];

    for (var trainer in trainers) {
      trainerWidgets.add(TrainerApiCard(trainer: trainer));
    }

    //* Add placeholder cards to fill up to 3 total cards
    final remainingSlots = 3 - trainers.length;
    for (int i = 0; i < remainingSlots; i++) {
      trainerWidgets.add(const TrainerPlaceholderCard());
    }

    return _buildVerticalList(trainerWidgets);
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onViewAllTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.textColorBlue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: onViewAllTap,
            borderRadius: BorderRadius.circular(4),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "View All",
                style: TextStyle(
                  color: Colors.yellow[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(List<Widget> cards, {double height = 200}) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) => cards[index],
      ),
    );
  }

  Widget _buildVerticalList(List<Widget> cards) {
    return Column(
      children: cards
          .map(
            (card) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: card,
            ),
          )
          .toList(),
    );
  }

  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: () => Get.to(() => const SearchScreen()),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4, top: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: AppColors.searchBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.withValues(alpha: 0.2), blurRadius: 4),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AbsorbPointer(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search courses or trainers...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: AppColors.hintText),
                suffixIcon: GestureDetector(
                  onTap: () => _showFilterDialog(Get.context!),
                  child: Icon(Icons.filter_list, color: AppColors.hintText),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: const Text('Filter Search'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Courses'),
              leading: const Icon(Icons.book),
              onTap: () {
                Get.back();
                Get.to(
                  () => const SearchScreen(initialFilter: SearchFilter.courses),
                );
              },
            ),
            ListTile(
              title: const Text('Marketplace'),
              leading: const Icon(Icons.shopping_cart),
              onTap: () {
                Get.back();
                Get.to(
                  () => const SearchScreen(
                    initialFilter: SearchFilter.marketplace,
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
        ],
      ),
    );
  }
}
