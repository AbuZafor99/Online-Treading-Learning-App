import 'package:get/get.dart';

class DialogController extends GetxController {
  var agreed = false.obs;

  void toggleAgreement(bool? value) {
    agreed.value = value ?? false;
  }
}
