import 'package:get/get.dart';
import 'package:flutter_ladydenily/features/course/models/course.dart';
import 'package:flutter_ladydenily/features/course/presentation/controllers/course_controller.dart';
import 'package:flutter_ladydenily/features/marketplace/models/marketplace_item_api_model.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/controllers/marketplace_controller.dart';
import '../screens/search_screen.dart';

class SearchController extends GetxController {
  final CourseController _courseController = Get.find<CourseController>();
  final MarketplaceController _marketplaceController =
      Get.find<MarketplaceController>();

  // Observable properties
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final Rx<SearchFilter> selectedFilter = SearchFilter.all.obs;

  // Filtered results
  final RxList<Course> filteredCourses = <Course>[].obs;
  final RxList<MarketplaceItemApiModel> filteredMarketplaceItems =
      <MarketplaceItemApiModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with all data
    _updateFilteredResults();
  }

  void search(String query) {
    searchQuery.value = query.toLowerCase();
    _updateFilteredResults();
  }

  void clearSearch() {
    searchQuery.value = '';
    filteredCourses.clear();
    filteredMarketplaceItems.clear();
  }

  void setFilter(SearchFilter filter) {
    selectedFilter.value = filter;
    _updateFilteredResults();
  }

  bool hasResults() {
    return filteredCourses.isNotEmpty || filteredMarketplaceItems.isNotEmpty;
  }

  bool shouldShowCourses() {
    return selectedFilter.value == SearchFilter.all ||
        selectedFilter.value == SearchFilter.courses;
  }

  bool shouldShowMarketplace() {
    return selectedFilter.value == SearchFilter.all ||
        selectedFilter.value == SearchFilter.marketplace;
  }

  void _updateFilteredResults() {
    if (searchQuery.value.isEmpty) {
      filteredCourses.clear();
      filteredMarketplaceItems.clear();
      return;
    }

    isLoading.value = true;

    try {
      // Filter courses
      if (shouldShowCourses()) {
        filteredCourses.value = _courseController.courses.where((course) {
          return course.name.toLowerCase().contains(searchQuery.value) ||
              course.description.toLowerCase().contains(searchQuery.value) ||
              course.coordinator.any(
                (coord) => coord.name.toLowerCase().contains(searchQuery.value),
              );
        }).toList();
      } else {
        filteredCourses.clear();
      }

      // Filter marketplace items
      if (shouldShowMarketplace()) {
        filteredMarketplaceItems.value = _marketplaceController.marketplaceItems
            .where((item) {
              return item.title.toLowerCase().contains(searchQuery.value) ||
                  item.description.toLowerCase().contains(searchQuery.value) ||
                  item.type.toLowerCase().contains(searchQuery.value);
            })
            .toList();
      } else {
        filteredMarketplaceItems.clear();
      }
    } catch (e) {
      print('Error filtering search results: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Utility method to get search suggestions
  List<String> getSearchSuggestions() {
    final suggestions = <String>[];

    // Add course names
    for (final course in _courseController.courses) {
      suggestions.add(course.name);
    }

    // Add marketplace item titles
    for (final item in _marketplaceController.marketplaceItems) {
      suggestions.add(item.title);
    }

    return suggestions.take(10).toList();
  }
}
