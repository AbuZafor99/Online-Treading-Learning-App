import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';
import 'package:flutter_ladydenily/core/network/constants/api_constants.dart';
import 'package:flutter_ladydenily/core/network/models/network_failure.dart';
import 'package:flutter_ladydenily/core/network/models/network_success.dart';
import '../domain/trainer_repository.dart';
import '../models/trainer_api_model.dart';

class TrainerRepositoryImpl implements TrainerRepository {
  final ApiClient _apiClient;

  TrainerRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<Either<NetworkFailure, NetworkSuccess<List<TrainerApiModel>>>>
  fetchTopTrainers() async {
    print(
      '[TrainerRepositoryImpl] fetching top trainers from course coordinators',
    );

    return _apiClient.get<List<TrainerApiModel>>(
      '${ApiConstants.baseUrl}/course/all-courses',
      fromJsonT: (json) {
        print(
          '[TrainerRepositoryImpl] fromJsonT received: ${json.runtimeType} -> $json',
        );

        List<TrainerApiModel> trainers = [];

        try {
          // Handle different JSON shapes
          List<dynamic> coursesList = [];

          if (json == null) {
            return trainers;
          } else if (json is Map && json['course'] is List) {
            coursesList = json['course'] as List;
          } else if (json is List) {
            coursesList = json;
          } else if (json is Map &&
              json['data'] is Map &&
              json['data']['course'] is List) {
            coursesList = json['data']['course'] as List;
          }

          print('[TrainerRepositoryImpl] found ${coursesList.length} courses');

          // Extract all coordinators/trainers from all courses
          Set<String> uniqueTrainerIds = {};

          for (var courseData in coursesList) {
            if (courseData is Map && courseData['coordinator'] is List) {
              List coordinators = courseData['coordinator'];

              for (var coordinatorData in coordinators) {
                if (coordinatorData is Map) {
                  try {
                    final trainer = TrainerApiModel.fromJson(
                      Map<String, dynamic>.from(coordinatorData),
                    );
                    // Only add unique trainers (avoid duplicates)
                    if (!uniqueTrainerIds.contains(trainer.id)) {
                      uniqueTrainerIds.add(trainer.id);
                      trainers.add(trainer);
                    }
                  } catch (e) {
                    print('[TrainerRepositoryImpl] error parsing trainer: $e');
                  }
                }
              }
            }
          }

          print(
            '[TrainerRepositoryImpl] extracted ${trainers.length} unique trainers',
          );

          // Sort by overall rating (descending) and take top trainers
          trainers.sort((a, b) => b.overallRating.compareTo(a.overallRating));
        } catch (e) {
          print('[TrainerRepositoryImpl] error processing trainers: $e');
        }

        return trainers;
      },
    );
  }
}
