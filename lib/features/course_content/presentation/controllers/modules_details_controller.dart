import 'package:get/get.dart';
import 'package:flutx_core/flutx_core.dart';
import '../../../../core/base/base_controller.dart';
import '../../../course/domain/course_repository.dart';
import '../../data/models/course_response_module.dart';
import '../../data/models/class_module_module.dart';

class ModulesDetailsController extends BaseController {
  final CourseRepository _courseRepository;

  ModulesDetailsController(this._courseRepository);

  final RxList<Module> _modules = <Module>[].obs;
  final Rx<CourseResponse?> _selectedCourse = Rx<CourseResponse?>(null);
  final RxMap<String, bool> _completionStatus = <String, bool>{}.obs;

  List<Module> get modules => _modules.toList();
  CourseResponse? get selectedCourse => _selectedCourse.value;

  RxList<Module> get rxModules => _modules;
  Rx<CourseResponse?> get rxSelectedCourse => _selectedCourse;

  @override
  void onInit() {
    super.onInit();
    final courseId = Get.arguments as String?;
    if (courseId != null && courseId.isNotEmpty) {
      getCourseDetails(courseId);
    }
  }

  bool isModuleCompleted(String moduleId) {
    return _completionStatus[moduleId] ?? false;
  }

  void toggleModuleCompletion(String moduleId) {
    final currentStatus = _completionStatus[moduleId] ?? false;
    _completionStatus[moduleId] = !currentStatus;
    _completionStatus.refresh();
  }

  Future<void> getCourseDetails(String courseId) async {
    setLoading(true);
    setError("");

    final result = await _courseRepository.getCourseDetails(courseId);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log("Get course details failed: ${fail.message}");
        setLoading(false);
      },
      (success) {
        _selectedCourse.value = success.data;
        _modules.value = success.data.modules;

        for (final module in success.data.modules) {
          _completionStatus.putIfAbsent(module.id, () => false);
        }

        DPrint.log(
          "Get course details success: ${success.data.name} with ${success.data.modules.length} modules",
        );
        setLoading(false);
      },
    );
  }

  void refreshModules() {
    if (_selectedCourse.value != null) {
      getCourseDetails(_selectedCourse.value!.id);
    }
  }
}
