import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';

import '../../core/common/widgets/custom_text.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(title: Text('Term & Condition')),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextForPrivacy(
                description:
                    'The Terms and Conditions outlined herein, including the Privacy Policy incorporated by reference as though fully stated, shall collectively be referred to as “The Agreement.” This Agreement is binding on every customer who accesses\n'
                    'www.legendarytradingacademy.com (hereinafter referred to as “Company”) and its successors and assigns. Furthermore, it supersedes and replaces any inconsistent statements found in our materials, advertisements, or websites.\n'
                    '\nThese Terms and Conditions are legally binding with respect to any “Transaction,” as defined below. By accessing our services, you agree to these Terms and Conditions as a prerequisite for engaging in any activities with us.\n\n'
                    'The terms “you” and “your” refer to the individual(s) or entity wishing to purchase the Company’s materials (collectively referred to as “Materials”), as well as those accessing or using our websites and providing personal information (collectively referred to as “Transaction”). The terms “we,” “our,” and “us” denote the Company and its employees, agents, members, owners, directors, officers, successors, and assigns. By utilizing our services and/or purchasing our Materials, you agree to the terms and conditions set forth herein.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Eligibility',
                description:
                    'By accessing the Website or utilizing the Services, you affirm that you are at least 18 years of age, a resident of the Philippines, and possess the legal capacity to enter into and form contracts in accordance with applicable law. This Agreement is rendered void in jurisdictions where such provisions are prohibited.',
              ),

              SizedBox(height: 8),
              CustomTextForPrivacy(
                title: 'Method of Payment & Refund Policy',
                description:
                    'LTA offers its materials for a one-time payment. To complete the purchase, a valid debit or credit card is required, and the corresponding amount will be charged to the card upon finalizing the transaction on our website.\n\n'
                    'When you avail yourself of the LTA services, you will gain access to the training materials available on the website; please note that no physical copies will be shipped or provided. \n\n'
                    'Refunds for payments made to the Company in connection with the purchased materials are only available if the materials are proven to be non-functional and the proper procedures for requesting a refund are followed. The Company does not guarantee refunds or credits for any other reasons, including, but not limited to, customer satisfaction with the materials. Under no circumstances will you be entitled to a refund or credit for any reason, including dissatisfaction with the materials.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
