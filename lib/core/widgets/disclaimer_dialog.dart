import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/core/widgets/check_button_with_text_disclaimers.dart';
import 'package:flutter_ladydenily/features/others/widgets/dialog_controller.dart';
import 'package:get/get.dart';
// make sure this path is correct

class DisclaimerDialog extends StatelessWidget {
  const DisclaimerDialog({
    super.key,
    required this.onAgree,
    required this.title,
    this.style,
    this.showCheckButton = false,
    this.subTitle,
    this.bottomText,
  });

  final VoidCallback onAgree;
  final String title;
  final String? subTitle;
  final String? bottomText;
  final TextStyle? style;
  final bool showCheckButton;

  @override
  Widget build(BuildContext context) {
    final DialogController controller = Get.put(DialogController());

    return Dialog(
      backgroundColor: AppColors.dialogBackgroundColor, // light gray background
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                showCheckButton
                    ? Center(
                        child: Text(
                          title,
                          style: style,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Text(title, style: style, textAlign: TextAlign.center),

                if (subTitle != null)
                  Text(
                    subTitle!,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.text,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                const SizedBox(height: 16),

                showCheckButton
                    ? Column(
                        children: [
                          CheckButtonWithTextDisclaimers(
                            text:
                                'Trading Risk: I understand that trading in financial markets involves significant risk and may result in the loss of capital. No individual or entity has guaranteed profits, and I take full responsibility for my trading decisions.',
                          ),

                          CheckButtonWithTextDisclaimers(
                            text:
                                'Educational Purpose: I understand that all materials, mentorship, and signals provided by Legendary Trading Academy (LTA) are strictly for educational purposes and do not constitute financial or investment advice.',
                          ),

                          CheckButtonWithTextDisclaimers(
                            text:
                                'Confidentiality & Non-Compete: I agree to keep all LTA course materials and proprietary strategies confidential. I will not reproduce, share, teach, or monetize any of LTA\'s content for at least three (3) years after completing the training, unless granted written permission.',
                          ),

                          CheckButtonWithTextDisclaimers(
                            text:
                                'Non-Payment Clause: I understand that failure to fulfill payment obligations may result in suspension or termination of access to classes, materials, and student communities. LTA reserves the right to pursue legal action for any unpaid balances or violations of payment agreements.',
                          ),

                          CheckButtonWithTextDisclaimers(
                            text:
                                'Legal & Enforcement: I acknowledge that this agreement is governed by the laws of the Republic of the Philippines. Any disputes will first be resolved amicably; if unresolved, they will be settled through arbitration under the Philippine Dispute Resolution Center, Inc. (PDRCI).',
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          _buildBulletPoint(
                            'This course is for educational purposes only.',
                          ),
                          _buildBulletPoint(
                            'Completion of the course does not guarantee any job placement, or professional qualification unless explicitly stated.',
                          ),
                          _buildBulletPoint(
                            'You are responsible for how you apply the knowledge gained.',
                          ),
                          _buildBulletPoint(
                            'No refunds will be issued once you access course materials (if applicable).',
                          ),
                        ],
                      ),

                const SizedBox(height: 20),

                if (showCheckButton)
                  Text(
                    bottomText!,
                    style: TextStyle(color: AppColors.text, fontSize: 12),
                  ),

                showCheckButton
                    ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFC107),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: onAgree,
                          child: Text(
                            'Agree & Continue',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Obx(
                        () => Row(
                          children: [
                            Checkbox(
                              value: controller.agreed.value,
                              onChanged: (val) {
                                controller.toggleAgreement(val);
                                if (val == true) onAgree();
                              },
                            ),
                            Expanded(
                              child: Text(
                                'I have read and agree to the terms and conditions above.',
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),

          // Top-right close button
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1D3557), // Dark blue
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.close, color: Colors.white, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '• ',
            style: TextStyle(fontSize: 16, color: AppColors.text),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14, color: AppColors.text),
            ),
          ),
        ],
      ),
    );
  }
}
