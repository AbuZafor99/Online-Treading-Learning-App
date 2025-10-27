import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../../core/base/base_controller.dart';
import '../../../course/domain/course_repository.dart';
import '../../data/models/class_module_module.dart';

class ResourcesController extends BaseController {
  final CourseRepository _repository;

  ResourcesController({required CourseRepository repository})
    : _repository = repository;

  final RxList<Module> _modules = <Module>[].obs;

  List<Module> get modules => _modules;

  @override
  void onInit() {
    super.onInit();
    final courseId = Get.arguments as String?;
    if (courseId != null && courseId.isNotEmpty) {
      fetchCourseModules(courseId);
    }
  }

  Future<void> fetchCourseModules(String courseId) async {
    setLoading(true);
    try {
      final result = await _repository.getCourseDetails(courseId);
      result.fold(
        (failure) {
          setError(failure.message);
          debugPrint('API Failure: ${failure.message}');
        },
        (success) {
          _modules.assignAll(success.data.modules);
          debugPrint('Modules fetched: ${success.data.modules}');
        },
      );
    } catch (e) {
      setError('Failed to load modules: $e');
      debugPrint('Exception: $e');
    } finally {
      setLoading(false);
    }
  }
}
