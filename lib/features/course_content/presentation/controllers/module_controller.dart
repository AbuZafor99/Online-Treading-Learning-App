import 'package:get/get.dart';
import 'package:flutx_core/flutx_core.dart';
import '../../../../core/base/base_controller.dart';
import '../../../course/domain/course_repository.dart';
import '../../data/models/course_response_module.dart';
import '../../data/models/class_module_module.dart';

class ModuleController extends BaseController {
  final CourseRepository _courseRepository;

  ModuleController(this._courseRepository);

  final RxList<CourseResponse> _courses = <CourseResponse>[].obs;
  final RxList<Module> _modules = <Module>[].obs;
  final Rx<CourseResponse?> _selectedCourse = Rx<CourseResponse?>(null);
  final RxInt _selectedIndex = 0.obs;

  List<CourseResponse> get courses => _courses.toList();
  List<Module> get modules => _modules.toList();
  CourseResponse? get selectedCourse => _selectedCourse.value;
  int get selectedIndex => _selectedIndex.value;

  Rx<CourseResponse?> get rxSelectedCourse => _selectedCourse;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> loadCourseById(String courseId) async {
    await getCourseDetails(courseId);
  }

  void selectItem(int index) {
    _selectedIndex.value = index;
  }

  Future<void> getAllCourses() async {
    setLoading(true);
    setError("");

    final result = await _courseRepository.getAllCourses();

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log("Get all courses failed: ${fail.message}");
        setLoading(false);
      },
      (success) {
        _courses.value = success.data;
        DPrint.log(
          "Get all courses success: ${success.data.length} courses loaded",
        );
        setLoading(false);
      },
    );
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
        DPrint.log("Get course details success: ${success.data.name}");
        setLoading(false);
      },
    );
  }

  Future<void> getCourseModules(String courseId) async {
    setLoading(true);
    setError("");
    final result = await _courseRepository.getCourseDetails(courseId);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log("Get course modules failed: ${fail.message}");
        setLoading(false);
      },
      (success) {
        _modules.value = success.data.modules;
        DPrint.log(
          "Get course modules success: ${success.data.modules.length} modules loaded",
        );
        setLoading(false);
      },
    );
  }

  void refreshModules() {
    if (_selectedCourse.value != null) {
      getCourseModules(_selectedCourse.value!.id);
    }
  }
}
