import 'package:flutter_ladydenily/core/utils/debug_print.dart';
import 'package:get/get.dart';

class SurveyController extends GetxController {
  RxString tradingExperience = ''.obs;
  RxString assetOfInterest = ''.obs;
  RxString mainGoal = ''.obs;
  RxString riskAppetite = ''.obs;
  RxList<String> learningModes = <String>[].obs;

  void selectSingle(RxString field, String value) {
    field.value = value;
  }

  void toggleLearningMode(String mode) {
    if (learningModes.contains(mode)) {
      learningModes.remove(mode);
    } else {
      learningModes.add(mode);
    }
  }

  // New: initialize from previous values
  void initFromPrevious({
    String? prevTradingExperience,
    String? prevAssetOfInterest,
    String? prevMainGoal,
    String? prevRiskAppetite,
    List<String>? prevLearningModes,
  }) {
    DPrint.log(
      "trading Experience $prevTradingExperience , $prevAssetOfInterest",
    );
    if (prevTradingExperience != null)
      tradingExperience.value = prevTradingExperience;
    if (prevAssetOfInterest != null)
      assetOfInterest.value = prevAssetOfInterest;
    if (prevMainGoal != null) mainGoal.value = prevMainGoal;
    if (prevRiskAppetite != null) riskAppetite.value = prevRiskAppetite;
    if (prevLearningModes != null) learningModes.value = prevLearningModes;
  }
}
