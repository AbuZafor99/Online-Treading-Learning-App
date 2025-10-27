import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/custom_text.dart';
import '../../core/common/widgets/app_scaffold.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text('Privacy Policy')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextForPrivacy(
                title: 'Who We Are',
                description:
                    'Legendary Trading Academy stands as a premier trading community focused on establishing a thorough financial education platform and school. We provide top-notch trading classes both online and onsite offering comprehensive trainings by our highly skilled educators, who are dedicated to positively impact Filipino families in navigating the financial markets. Our mission is to improve lives through financial literacy, enabling individuals to thrive in financial trading. Our commitment extends beyond teaching the mechanics of trading; we strive to foster a supportive community where members can share experiences, insights, and encouragement. By cultivating a collaborative environment, we empower our students to grow both personally and professionally. \n'
                    '\nWe understand that every learner’s journey is unique, which is why we offer personalized learning paths tailored to individual goals and skill levels. Whether you are a beginner taking your first steps into the world of trading or an experienced trader looking to refine your strategies, our courses are designed to meet you where you are. \n'
                    '\nAt Legendary Trading Academy, we believe that financial education is a lifelong pursuit. That’s why we continuously update our curriculum to reflect the latest market trends and technological advancements, ensuring our community stays ahead of the curve.\n'
                    '\nJoin us on this transformative journey and unlock the potential to achieve your financial dreams while gaining the freedom to live the life you desire.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Privacy Policy',
                description:
                    'What is the Privacy Policy and what does it cover?\n'
                    '\nWe at Legendary Trading Academy want you to understand what information we collect, and how we use and share it. That’s why we encourage you to read our Privacy Policy. This helps you use our Products in the way that’s right for you.\n'
                    '\nIn the Privacy Policy, we explain how we collect, use, share, retain and transfer information. We also let you know your rights. Each section of the Policy includes helpful examples and simpler language to make our practices easier to understand. It’s important to us that you know how to control your privacy.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Media',
                description:
                    'When uploading images to the website, please refrain from including embedded location data (EXIF GPS). Visitors can download these images and extract any location information contained within.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Cookies',
                description:
                    'When you log into this site using an account, a temporary cookie will be created to verify whether your browser accepts cookies. This cookie does not store any personal information and will be deleted upon closing your browser.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Embedded Content from External Websites',
                description:
                    'Articles featured on this site may include embedded content such as videos, images, and articles. This embedded content operates similarly to how it would on the external website itself.\n'
                    '\nThese external sites may collect data about you, use cookies, implement additional third-party tracking, and monitor your interactions with the embedded content, especially if you have an account and are logged into that site.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Data Retention Policy',
                description:
                    'When you submit content, both the submission and its metadata are stored indefinitely. This practice allows for the automatic identification and approval of related submissions, eliminating the need for moderation queues.\n'
                    '\nFor users who register on our website, we retain the personal information provided in their user profiles. All users have the right to view, edit, or delete their personal information at any time, with the exception of their email addresses. Website administrators also have the capability to view and modify this information.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Your Rights Regarding Your Data',
                description:
                    'If you possess an account on this site or have submitted comments, you have the right to request an exported file containing the personal data we hold about you, including any information you have provided. Additionally, you may request the deletion of any personal data in our possession. However, please note that this does not encompass data we are required to retain for administrative, legal, or security purposes.\n'
                    '\nVisitor content may be subject to review by an automated spam detection service.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
