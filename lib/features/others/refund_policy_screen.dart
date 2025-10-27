import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/common/widgets/custom_text_for_refund_policy.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';

import '../../core/common/widgets/custom_text.dart';
import '../../core/theme/app_colors.dart';

class RefundPolicyScreen extends StatelessWidget {
  const RefundPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text('Refund Policy')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextForPrivacy(
                description:
                    'Legendary Trading Academy promised and assured to deliver the best quality of service in CFDs Trading and Financial Literacy Education for individuals who want to change their financial situation through financial literacy. However, the education we provide is limited only to the willingness and commitment of our students to be successful in this industry.\n\n'
                    'In alignment with this, we expect our students to approach this course with sincerity, demonstrating their commitment and responsibility in applying the lessons and skills imparted.\n\n'
                    'In specific instances and under certain conditions, Legendary Trading Academy offers an implementation guarantee for students who find the academy’s services to be ineffective or unprofitable.This guarantee is designed to ensure that our students receive not only educational value but also the practical tools necessary to succeed. To qualify for the implementation guarantee, students must have actively participated in all required classes, completed all assignments, and utilized the available resources as directed.\n\n'
                    'Legendary Trading Academy stands by its mission to empower individuals through education, and this guarantee reflects our confidence in the effectiveness of our program. We encourage students to communicate openly with instructors and seek guidance whenever challenges arise, as we are committed to supporting each student’s journey toward financial independence.\n\n'
                    'Together, we can create a brighter financial future, grounded in knowledge, perseverance, and strategic action. Let us embark on this journey with determination and a shared vision for success.',
              ),

              SizedBox(height: 8),
              CustomText(
                'Requirements for Refund',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),

              SizedBox(height: 8),
              CustomTextForRefundPolicy(
                number: '1.',
                text:
                    'To initiate a refund request, the student must contact our support team via email at admin@legendarytradingacademy.com, providing detailed evidence of the issues faced. This may include screenshots, error messages, or any other relevant documentation.',
              ),

              CustomTextForRefundPolicy(
                number: '2.',
                text:
                    'Our team will review the submitted evidence within 3 business days and, if the claim is validated, will proceed with the refund process. The refund will be processed through the bank transfer.',
              ),

              CustomTextForRefundPolicy(
                number: '3.',
                text:
                    'Please note that refund processing times may vary based on your bank or card issuer and can take up to 14 business days to reflect in your account.',
              ),

              CustomTextForRefundPolicy(
                number: '4.',
                text:
                    'Refunds are not available for services that have been accessed or utilized beyond the initial 3-day eligibility window, except in cases outlined in our implementation guarantee policy.',
              ),

              CustomTextForRefundPolicy(
                number: '5.',
                text:
                    'Legendary Trading Academy reserves the right to deny refund requests that do not meet the specified criteria or if fraudulent activity is suspected',
              ),

              CustomTextForPrivacy(
                description:
                    'By understanding and agreeing to these terms, students ensure a smooth and fair process for resolving any issues related to their purchase. We strive to maintain transparency and fairness in all our dealings, ensuring that our community remains a supportive and trustworthy environment for all members.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
