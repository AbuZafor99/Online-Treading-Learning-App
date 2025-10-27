import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/community/presentation/controllers/community_controller.dart';
import 'package:flutter_ladydenily/features/community/presentation/widgets/community_list_item.dart';
import 'package:get/get.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CommunityController>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.searchBackgroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  onChanged: controller.searchCommunity,
                  decoration: InputDecoration(
                    hintText: 'Search Community',
                    hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
            ),

            // Community List
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.buttonColor,
                    ),
                  );
                }

                if (controller.filteredCommunityList.isEmpty) {
                  return Center(
                    child: Text(
                      'No communities found',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: controller.filteredCommunityList.length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, color: Colors.grey[300], indent: 76),
                  itemBuilder: (context, index) {
                    final item = controller.filteredCommunityList[index];
                    return CommunityListItem(
                      item: item,
                      onTap: () {
                        // TODO: Navigate to community detail screen
                        print('Tapped on ${item.displayName}');
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
