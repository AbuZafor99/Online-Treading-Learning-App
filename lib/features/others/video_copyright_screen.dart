import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import '../../core/common/widgets/custom_text.dart';

class VideoCopyrightScreen extends StatelessWidget {
  const VideoCopyrightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text('Video Copyright')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextForPrivacy(
                title: 'Introduction',
                description:
                    'This Agreement governs the use of private videos and related content (“Content”) accessible through the Legendary Trading Academy (“Platform”). By accessing or utilizing the Platform, you agree to comply with and be bound by these terms.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Copyright & Usage',
                description:
                    'All private videos and content available on the Platform are protected by copyright laws. Users are granted a non-exclusive, non-transferable license to access and view the private videos strictly for personal, non-commercial use. Any unauthorized use, reproduction, or distribution of the Content is expressly prohibited.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Downloads Prohibited',
                description:
                    'Users are explicitly prohibited from downloading, saving, or otherwise creating copies of private videos. The Content is intended solely for streaming and viewing. Any attempt to download or store the videos constitutes a violation of these terms and may result in legal action.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Account Sharing',
                description:
                    'Sharing user accounts is strictly forbidden. Each account is designed for individual subscriber use only. Sharing login credentials is a breach of these terms and may lead to immediate account termination.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Penalty for Violation',
                description:
                    'In the event of account termination due to a breach of these terms, the user agrees to pay a penalty of \$20,000 as liquidated damages. This penalty is intended to compensate Legendary Trading Academy for the harm caused by the violation and is not intended as a punitive measure.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Dispute Resolution',
                description:
                    'Any disputes arising from or in connection with this Agreement will be resolved through arbitration in accordance with the laws of the Republic of the Philippines. The prevailing party in any arbitration shall be entitled to recover reasonable attorneys’ fees and costs.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Changes to Terms',
                description:
                    'Legendary Trading Academy reserves the right to modify or update these terms and conditions at any time. Users will be notified of any changes, and continued use of the Platform constitutes acceptance of the revised terms.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Governing Law',
                description:
                    'This Agreement shall be governed by and construed in accordance with the laws of the Republic of the Philippines, without regard to its conflict of law principles.Any legal proceedings or disputes arising out of or relating to this Agreement shall be exclusively resolved in the courts of the Philippines. By agreeing to these terms, you consent to the jurisdiction of these courts and waive any objections to such venue, including any claims of inconvenient forum.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Severability',
                description:
                    'If any provision of this Agreement is found to be unenforceable or invalid under applicable law, such provision shall be modified to reflect the parties’ intention, or deemed severed, and the remaining provisions shall continue in full force and effect.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Waiver',
                description:
                    'The failure of Legendary Trading Academy to enforce any provision or right of this Agreement shall not constitute a waiver of such provision or right or any other provisions or rights under this Agreement.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Contact Us',
                description:
                    'If you have any questions about this Agreement or need further clarification, please reach out to our support team at admin@legendarytradingacademy.com. We are here to assist you and ensure that your experience with us is positive and fulfilling.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Contact Information',
                description:
                    'For questions or concerns regarding these terms and conditions, please contact Coach Lady Denily at +639179270854.\n \n'
                    'By using the Platform, you acknowledge that you have read, understood, and agree to be bound by these terms and conditions.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
