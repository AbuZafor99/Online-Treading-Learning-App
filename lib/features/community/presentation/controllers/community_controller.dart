import 'package:flutter_ladydenily/features/community/domain/community_repository.dart';
import 'package:flutter_ladydenily/features/community/models/community_item.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  final CommunityRepository repository;

  CommunityController({required this.repository});

  final communityList = <CommunityItem>[].obs;
  final filteredCommunityList = <CommunityItem>[].obs;
  final isLoading = false.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCommunityList();
  }

  Future<void> fetchCommunityList() async {
    try {
      isLoading.value = true;
      print('[CommunityController] calling repository.fetchCommunityList()');
      final result = await repository.fetchCommunityList();

      result.fold(
        (failure) {
          print('[CommunityController] failure: ${failure.message}');
          communityList.clear();
          filteredCommunityList.clear();
        },
        (success) {
          print(
            '[CommunityController] success.data length: ${success.data.length}',
          );
          communityList.assignAll(success.data);
          filteredCommunityList.assignAll(success.data);
          print('>>>>>>> API COMMUNITY LIST loaded: ${communityList.length}');
        },
      );
    } catch (e) {
      print('Error fetching community list: $e');
      communityList.clear();
      filteredCommunityList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void searchCommunity(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredCommunityList.assignAll(communityList);
    } else {
      filteredCommunityList.assignAll(
        communityList
            .where(
              (item) =>
                  item.displayName.toLowerCase().contains(query.toLowerCase()),
            )
            .toList(),
      );
    }
  }
}
