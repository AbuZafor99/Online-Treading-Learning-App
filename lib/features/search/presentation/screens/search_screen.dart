import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/search/presentation/controllers/search_controller.dart'
    as search;
import 'package:flutter_ladydenily/features/course/presentation/widgets/course_details_card.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/widgets/marketplace_api_card.dart';
import 'package:get/get.dart';

enum SearchFilter { all, courses, marketplace }

class SearchScreen extends StatefulWidget {
  final SearchFilter initialFilter;

  const SearchScreen({super.key, this.initialFilter = SearchFilter.all});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final search.SearchController _controller = Get.put(
    search.SearchController(),
  );
  late SearchFilter _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter;
    _controller.setFilter(_selectedFilter);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    _controller.search(query);
  }

  void _onFilterChanged(SearchFilter filter) {
    setState(() {
      _selectedFilter = filter;
    });
    _controller.setFilter(filter);
    if (_searchController.text.isNotEmpty) {
      _controller.search(_searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside the search field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search',
            style: TextStyle(
              color: AppColors.appBarTitle,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            //* <--- Search Bar --->
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: 'Search courses, trainers, or marketplace items...',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.hintText,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.clear,
                            color: AppColors.hintText,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            _controller.clearSearch();
                            // Dismiss keyboard after clearing
                            FocusScope.of(context).unfocus();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: AppColors.searchBackgroundColor,
                ),
              ),
            ),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: SearchFilter.values.map((filter) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      label: Text(_getFilterLabel(filter)),
                      selected: _selectedFilter == filter,
                      onSelected: (selected) => _onFilterChanged(filter),
                      selectedColor: AppColors.primaryBlue.withOpacity(0.2),
                      checkmarkColor: AppColors.primaryBlue,
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 16),

            // Search Results
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_controller.searchQuery.value.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'Start typing to search',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                final hasResults = _controller.hasResults();
                if (!hasResults) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No results found',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        Text(
                          'Try adjusting your search or filter',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return _buildSearchResults();
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;
        final crossAxisCount = isTablet ? 2 : 1;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course Results
              if (_controller.shouldShowCourses()) ...[
                if (_controller.filteredCourses.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      'Courses',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColorBlue,
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisExtent: 340,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _controller.filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = _controller.filteredCourses[index];
                      return CourseDetailsCard(course: course);
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ],

              // Marketplace Results
              if (_controller.shouldShowMarketplace()) ...[
                if (_controller.filteredMarketplaceItems.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      'Marketplace',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColorBlue,
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisExtent: 320,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: _controller.filteredMarketplaceItems.length,
                    itemBuilder: (context, index) {
                      final item = _controller.filteredMarketplaceItems[index];
                      return MarketplaceApiCard(item: item);
                    },
                  ),
                ],
              ],
            ],
          ),
        );
      },
    );
  }

  String _getFilterLabel(SearchFilter filter) {
    switch (filter) {
      case SearchFilter.all:
        return 'All';
      case SearchFilter.courses:
        return 'Courses';
      case SearchFilter.marketplace:
        return 'Marketplace';
    }
  }
}
