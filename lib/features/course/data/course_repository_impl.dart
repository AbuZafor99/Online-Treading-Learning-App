import 'package:dartz/dartz.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';

import '../../../core/network/constants/api_constants.dart';
import '../../../core/network/models/network_failure.dart';
import '../../../core/network/models/network_success.dart';
import '../domain/course_repository.dart';
import '../models/course.dart';
import 'package:flutter_ladydenily/core/network/network_result.dart';
import 'package:flutter_ladydenily/features/course_content/data/models/course_response_module.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiClient _apiClient;
  CourseRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Either<NetworkFailure, NetworkSuccess<List<Course>>>>
  fetchAllCourses() {
    return _apiClient.get<List<Course>>(
      '${ApiConstants.baseUrl}/course/all-courses',
      fromJsonT: (json) {
        print('[CourseRepo] Parsing JSON: ${json.runtimeType}');

        if (json == null) {
          print('[CourseRepo] JSON is null, returning empty list');
          return <Course>[];
        }

        // Primary case: json is {"course": [...], "meta": {...}}
        if (json is Map<String, dynamic> && json['course'] is List) {
          final list = json['course'] as List;
          print('[CourseRepo] Found course array with ${list.length} items');
          return list
              .map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        // Fallback: json is directly a List
        if (json is List) {
          print('[CourseRepo] JSON is direct list with ${json.length} items');
          return json
              .map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        // Legacy case: nested data.course structure
        if (json is Map<String, dynamic> &&
            json['data'] is Map &&
            (json['data'] as Map)['course'] is List) {
          final list = (json['data'] as Map)['course'] as List;
          print(
            '[CourseRepo] Found nested data.course with ${list.length} items',
          );
          return list
              .map((e) => Course.fromJson(e as Map<String, dynamic>))
              .toList();
        }

        print('[CourseRepo] No matching pattern, returning empty list');
        print(
          '[CourseRepo] JSON keys: ${json is Map<String, dynamic> ? json.keys : "not a map"}',
        );
        return <Course>[];
      },
    );
  }

  // ---- Added to satisfy CourseRepository interface ----
  @override
  NetworkResult<List<CourseResponse>> getAllCourses() {
    return _apiClient.get<List<CourseResponse>>(
      ApiConstants.course.getAllCourses,
      fromJsonT: (json) =>
          (json as List).map((e) => CourseResponse.fromJson(e)).toList(),
    );
  }

  // ---- Added methods for course_content (NetworkResult based) ----
  // Note: these use the same ApiClient instance. They are added here
  // alongside existing code as requested.

  NetworkResult<List<CourseResponse>> getAllCoursesContent() {
    return _apiClient.get<List<CourseResponse>>(
      ApiConstants.course.getAllCourses,
      fromJsonT: (json) =>
          (json as List).map((e) => CourseResponse.fromJson(e)).toList(),
    );
  }

  @override
  NetworkResult<CourseResponse> getCourseDetails(String courseId) {
    return _apiClient.get<CourseResponse>(
      '${ApiConstants.course.getCourseDetails}/$courseId',
      fromJsonT: (json) => CourseResponse.fromJson(json),
    );
  }

  @override
  NetworkResult<List<CourseResponse>> getCourseModules(String moduleId) {
    return _apiClient.get<List<CourseResponse>>(
      '${ApiConstants.course.getCourseModules}/$moduleId',
      fromJsonT: (json) =>
          (json as List).map((e) => CourseResponse.fromJson(e)).toList(),
    );
  }

  @override
  Future<Either<NetworkFailure, NetworkSuccess<Map<String, dynamic>>>>
  createPayment({
    required String userId,
    required num price,
    required String courseId,
    required String type,
  }) async {
    final endpoint = '${ApiConstants.baseUrl}/payment/create-payment';
    print(
      '[CourseRepositoryImpl] creating payment for courseId: $courseId, price: $price',
    );

    return _apiClient.post<Map<String, dynamic>>(
      endpoint,
      data: {
        'userId': userId,
        'price': price,
        'courseId': courseId,
        'type': type,
      },
      fromJsonT: (json) {
        // Expecting { invoiceUrl, transactionId, message }
        if (json == null) return <String, dynamic>{};
        if (json is Map<String, dynamic>) return json;
        try {
          return Map<String, dynamic>.from(json);
        } catch (e) {
          return <String, dynamic>{};
        }
      },
    );
  }

  @override
  Future<Either<NetworkFailure, NetworkSuccess<Map<String, dynamic>>>>
  confirmPayment({required String invoiceId}) async {
    final endpoint = '${ApiConstants.baseUrl}/payment/confirm-payment';
    print(
      '[CourseRepositoryImpl] confirming payment for invoiceId: $invoiceId',
    );

    return _apiClient.post<Map<String, dynamic>>(
      endpoint,
      data: {'invoiceId': invoiceId},
      fromJsonT: (json) {
        if (json == null) return <String, dynamic>{};
        if (json is Map<String, dynamic>) return json;
        try {
          return Map<String, dynamic>.from(json);
        } catch (e) {
          return <String, dynamic>{};
        }
      },
    );
  }
}
