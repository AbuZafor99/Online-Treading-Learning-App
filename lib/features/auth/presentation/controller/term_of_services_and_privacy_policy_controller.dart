import 'package:get/get.dart';

class TermOfServicesAndPrivacyPolicyController extends GetxController {
  // observable boolean
  var privacy = false.obs;

  void toggleprivacy() {
    privacy.value = !privacy.value;
  }
}
