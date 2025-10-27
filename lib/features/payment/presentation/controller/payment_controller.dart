import 'package:get/get.dart';

import '../screens/payment_screen.dart';

class PaymentController extends GetxController {
  void processPayment() {
    Get.to(() => const PaymentScreen());
  }

  // void completePayment() {
  //   Get.back(); // Go back from payment screen
  //   showSuccessDialog();
  // }
  //
  // void showSuccessDialog() {
  //   Get.dialog(const SuccessDialog(), barrierDismissible: false);
  // }

  void completeEnrollment() {
    Get.snackbar('Success', 'Enrollment completed!');
    // Navigate to course content or home
  }
}
