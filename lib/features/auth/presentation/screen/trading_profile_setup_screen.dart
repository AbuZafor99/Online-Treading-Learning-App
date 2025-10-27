import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutx_core/flutx_core.dart';
import 'package:get/get.dart';
import '../controller/survey_controller.dart';

class TradingProfileSetupScreen extends StatefulWidget {
  const TradingProfileSetupScreen({super.key, this.isFromProfile});
  final bool? isFromProfile;

  @override
  State<TradingProfileSetupScreen> createState() =>
      _TradingProfileSetupScreenState();
}

class _TradingProfileSetupScreenState extends State<TradingProfileSetupScreen> {
  final SurveyController c = Get.put(SurveyController(), permanent: true);

  final _authController = Get.find<AuthController>();
  final _profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();

    final profile = _profileController.userInfo.value?.trendingProfile;

    // Only initialize if the values are empty
    if (c.tradingExperience.value.isEmpty &&
        c.assetOfInterest.value.isEmpty &&
        c.mainGoal.value.isEmpty &&
        c.riskAppetite.value.isEmpty &&
        c.learningModes.isEmpty) {
      c.initFromPrevious(
        prevTradingExperience: profile?.tradingExperience ?? '',
        prevAssetOfInterest: profile?.assetsOfInterest ?? '',
        prevMainGoal: profile?.mainGoal ?? '',
        prevRiskAppetite: profile?.riskAppetite ?? '',
        prevLearningModes: profile?.preferredLearning ?? [],
      );
    }
  }

  void _submit() async {
    if (widget.isFromProfile == true) {
      //  Save trading profile using ProfileController
      await _profileController.tradingProfileSetup(
        c.tradingExperience.toString(),
        c.assetOfInterest.toString(),
        c.mainGoal.toString(),
        c.riskAppetite.toString(),
        c.learningModes,
      );

      //  After success, go back to ProfileScreen
      if (_profileController.isLoading.value) {
        Get.snackbar(
          "Success",
          "Trading profile updated successfully!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back(); //returns to ProfileScreen
      }
    } else {
      //  Use AuthController flow during onboarding
      await _authController.tradingProfileSetup(
        c.tradingExperience.toString(),
        c.assetOfInterest.toString(),
        c.mainGoal.toString(),
        c.riskAppetite.toString(),
        c.learningModes,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Trading Profile Setup Fields:',
          style: TextStyle(
            color: Color(0xFF1A3E74),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Please answer the following to help us personalize your trading journey inside the app.',
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
              ),

              SizedBox(height: 12),

              sectionCard("1. Trading Experience", [
                buildSingleCheckbox("Zero knowledge", c.tradingExperience),
                buildSingleCheckbox("1–6 months", c.tradingExperience),
                buildSingleCheckbox("6–12 months", c.tradingExperience),
                buildSingleCheckbox("1–5 years", c.tradingExperience),
              ]),

              SizedBox(height: 12),

              sectionCard("2. Assets of Interest", [
                buildSingleCheckbox("Forex", c.assetOfInterest),
                buildSingleCheckbox("Commodities", c.assetOfInterest),
                buildSingleCheckbox("Indices", c.assetOfInterest),
                buildSingleCheckbox("Crypto", c.assetOfInterest),
                buildSingleCheckbox("Stocks", c.assetOfInterest),
              ]),

              SizedBox(height: 12),

              sectionCard("3. Main Goal in Trading", [
                buildSingleCheckbox("Passive income", c.mainGoal),
                buildSingleCheckbox("Career in trading", c.mainGoal),
                buildSingleCheckbox("Side hustle", c.mainGoal),
                buildSingleCheckbox("Funded account", c.mainGoal),
                buildSingleCheckbox("Build confidence/discipline", c.mainGoal),
              ]),

              SizedBox(height: 12),

              sectionCard("4. Risk Appetite", [
                buildSingleCheckbox("Low", c.riskAppetite),
                buildSingleCheckbox("Moderate", c.riskAppetite),
                buildSingleCheckbox("High", c.riskAppetite),
              ]),

              SizedBox(height: 12),
              sectionCard("5. Preferred Learning Mode (Multiple choice)", [
                buildMultiCheckbox("Face-to-Face Classes"),
                buildMultiCheckbox("Online Zoom Classes"),
                buildMultiCheckbox("1-on-1 Mentorship"),
                buildMultiCheckbox("Self-Paced Video Courses"),
              ]),

              SizedBox(height: 20),

              Obx(
                () => context.primaryButton(
                  onPressed: () {
                    _submit();
                  },
                  isLoading: _authController.isLoading.value,
                  text: 'Continue',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Section container
  Widget sectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFE8ECF1),
        border: Border.all(color: Colors.blueGrey.shade100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  // Single-choice checkbox row
  Widget buildSingleCheckbox(String label, RxString field) {
    DPrint.log("checkbox for $label with field value ${field.value}");
    return Obx(
      () => Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: Checkbox(
              side: BorderSide(
                color: Color(0xFF4E4E4E), // border color when unchecked
                width: 1, // border width
              ),
              value: field.value == label,
              onChanged: (_) => c.selectSingle(field, label),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4E4E4E),
            ),
          ),
        ],
      ),
    );
  }

  // Multi-choice checkbox row
  // Multi-choice checkbox row
  Widget buildMultiCheckbox(String label) {
    return Obx(() {
      final isChecked = c.learningModes.contains(label);
      return Row(
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: Checkbox(
              value: isChecked,
              onChanged: (_) => c.toggleLearningMode(label),
              side: BorderSide(
                color: Color(0xFF4E4E4E), // border color when unchecked
                width: 1,
              ),
              //activeColor: Colors.blue, // checked color
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0xFF4E4E4E),
            ),
          ),
        ],
      );
    });
  }
}
