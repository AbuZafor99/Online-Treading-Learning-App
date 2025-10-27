import 'package:get/get.dart';
import 'package:flutx_core/flutx_core.dart';
import '../../../../core/base/base_controller.dart';
import '../../../course/domain/course_repository.dart';
import '../../data/models/class_module_module.dart';
import '../../data/models/course_response_module.dart';

class ModulesDetailsController extends BaseController {
  final CourseRepository _courseRepository;

  ModulesDetailsController(this._courseRepository);

  final RxList<Module> _modules = <Module>[].obs;
  final Rx<CourseResponse?> _courseDetails = Rx<CourseResponse?>(null);
  final RxMap<String, bool> _completionStatus = <String, bool>{}.obs;

  List<Module> get modules => _modules.toList();
  CourseResponse? get courseDetails => _courseDetails.value;
  Map<String, bool> get completionStatus => _completionStatus;

  @override
  void onInit() {
    super.onInit();
    final courseId = Get.arguments as String?;
    if (courseId != null) {
      getCourseDetails(courseId);
    } else {
      setError("No course ID provided");
      setLoading(false);
    }
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
        _courseDetails.value = success.data;
        _modules.value = success.data.modules;

        for (var module in success.data.modules) {
          _completionStatus[module.id] = false;
        }

        DPrint.log("Get course details success: ${success.data.name}");
        setLoading(false);
      },
    );
  }

  void toggleModuleCompletion(String moduleId) {
    _completionStatus[moduleId] = !(_completionStatus[moduleId] ?? false);
    _completionStatus.refresh();
  }

  bool isModuleCompleted(String moduleId) {
    return _completionStatus[moduleId] ?? false;
  }

  int get completedModulesCount {
    return _completionStatus.values.where((completed) => completed).length;
  }

  double get progressPercentage {
    if (_modules.isEmpty) return 0.0;
    return completedModulesCount / _modules.length;
  }

  void refreshModules() {
    if (_courseDetails.value != null) {
      getCourseDetails(_courseDetails.value!.id);
    }
  }
}
