import 'package:get/get.dart';
import '../../domain/trainer_repository.dart';
import '../../models/trainer_api_model.dart';

class TrainerController extends GetxController {
  final TrainerRepository repository;
  TrainerController({required this.repository});

  final topTrainers = <TrainerApiModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTopTrainers();
  }

  Future<void> fetchTopTrainers() async {
    try {
      isLoading.value = true;
      print('[TrainerController] calling repository.fetchTopTrainers()');
      final result = await repository.fetchTopTrainers();
      print(
        '[TrainerController] repository returned type: ${result.runtimeType}',
      );

      result.fold(
        (failure) {
          print('[TrainerController] failure: ${failure.message}');
          topTrainers.clear();
        },
        (success) {
          print(
            '[TrainerController] success.data length: ${success.data.length}',
          );
          if (success.data.isNotEmpty) {
            print(
              '[TrainerController] first trainer: ${success.data.first.displayName} (rating: ${success.data.first.overallRating})',
            );
          }
          topTrainers.assignAll(success.data);
          print('>>>>>>> API TRAINERS loaded: ${topTrainers.length}');
        },
      );
    } catch (e, st) {
      print('[TrainerController] fetchTopTrainers exception: $e\n$st');
      topTrainers.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
