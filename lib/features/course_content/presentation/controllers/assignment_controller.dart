import 'package:file_picker/file_picker.dart';
import 'package:get/state_manager.dart';

class AssignmentController extends GetxController {
  final status = 'Pending'.obs;
  final fileName = ''.obs;
  final filePath = ''.obs;

  void setFile(String name, String path) {
    fileName.value = name;
    filePath.value = path;
  }

  Future<void> submit() async {
    // Future: call API to upload using the picked file path
    if (fileName.value.isNotEmpty) {
      // Here you would typically use a service to upload the file
      // For example:
      // final success = await ApiService.uploadFile(filePath.value);
      // if (success) {
      //   status.value = 'Submitted';
      // } else {
      //   // Handle upload failure
      // }
      status.value = 'Uploaded';
    }
  }

  Future<void> pickAndUpload() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.single;
      setFile(file.name, file.path ?? '');
      await Future.delayed(const Duration(milliseconds: 300));
      await submit();
    }
  }
}
