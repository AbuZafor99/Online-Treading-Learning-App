import 'package:get/get.dart';
import '../../domain/course_repository.dart';
import '../../models/course.dart';

class CourseController extends GetxController {
  final CourseRepository repository;
  CourseController({required this.repository});

  final courses = <Course>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      isLoading.value = true;
      print('[CourseController] calling repository.fetchAllCourses()');
      final result = await repository.fetchAllCourses();
      print(
        '[CourseController] repository returned type: ${result.runtimeType}',
      );

      // Either<NetworkFailure, NetworkSuccess<List<Course>>> expected
      result.fold(
        (failure) {
          print('[CourseController] fetch failed: ${failure.message}');
          courses.clear();
        },
        (success) {
          final payload = success.data; // NetworkSuccess.data is non-nullable
          courses.assignAll(payload);
          print('>>>>>>> API COURSES loaded: ${courses.length}');
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Create payment and return payment details map with invoice URL and transaction ID.
  /// On success the UI caller can navigate to the invoice URL.
  Future<Map<String, String>?> createPaymentForCourse({
    required String userId,
    required num price,
    required String courseId,
    String type = 'course',
  }) async {
    try {
      final res = await repository.createPayment(
        userId: userId,
        price: price,
        courseId: courseId,
        type: type,
      );
      Map<String, String>? paymentDetails;
      res.fold(
        (failure) {
          print('[CourseController] createPayment failed: ${failure.message}');
        },
        (success) {
          final map = success.data;
          final invoiceUrl =
              map['invoiceUrl'] as String? ?? map['invoice_url'] as String?;
          final transactionId =
              map['transactionId'] as String? ??
              map['transaction_id'] as String? ??
              map['id'] as String?;

          print(
            '[CourseController] createPayment success invoiceUrl: $invoiceUrl',
          );
          print(
            '[CourseController] createPayment transactionId: $transactionId',
          );

          if (invoiceUrl != null) {
            paymentDetails = {
              'invoiceUrl': invoiceUrl,
              if (transactionId != null) 'transactionId': transactionId,
            };
          }
        },
      );
      return paymentDetails;
    } catch (e) {
      print('[CourseController] createPayment exception: $e');
      return null;
    }
  }

  /// Confirm payment completion
  Future<bool> confirmPayment({required String invoiceId}) async {
    try {
      final res = await repository.confirmPayment(invoiceId: invoiceId);
      bool success = false;
      res.fold(
        (failure) {
          print('[CourseController] confirmPayment failed: ${failure.message}');
        },
        (successData) {
          print(
            '[CourseController] confirmPayment success: ${successData.data}',
          );
          success = true;
        },
      );
      return success;
    } catch (e) {
      print('[CourseController] confirmPayment exception: $e');
      return false;
    }
  }
}
