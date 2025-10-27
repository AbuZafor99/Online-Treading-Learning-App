import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/home/presentation/controllers/trainer_controller.dart';
import 'package:flutter_ladydenily/features/home/presentation/widgets/trainer_api_card.dart';
import 'package:get/get.dart';

class TrainerAllScreen extends StatelessWidget {
  const TrainerAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trainerController = Get.find<TrainerController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Trainers',
          style: TextStyle(
            color: AppColors.titleTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: AppColors.titleTextColor),
      ),
      body: Obx(() {
        if (trainerController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final trainers = trainerController.topTrainers;

        if (trainers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_off_outlined,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 16),
                Text(
                  'No trainers available',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await trainerController.fetchTopTrainers();
          },
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: trainers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return TrainerApiCard(trainer: trainers[index]);
            },
          ),
        );
      }),
    );
  }
}
