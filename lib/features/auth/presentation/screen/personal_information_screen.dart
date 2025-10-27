import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/widgets/app_scaffold.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/extensions/input_decoration_extensions.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';
import 'package:flutter_ladydenily/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/upload_profile_screen.dart';
import 'package:flutter_ladydenily/features/others/terms_and_disclaimer_dialog_screen.dart';
import 'package:flutx_core/flutx_core.dart';
import 'package:get/get.dart';

import '../../../../core/common/texts/texts.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  final _authController = Get.find<AuthController>();

  final TextEditingController _personalNameController = TextEditingController();
  final TextEditingController _personalAgeController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  late int age = int.tryParse(_personalAgeController.text) ?? 0;

  final FocusNode _personalNameFocus = FocusNode();
  final FocusNode _personalAgeFocus = FocusNode();
  final FocusNode _nationalityFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  String gender = "Male";

  void _submit() {
    _authController.personalInfo(
      _personalNameController.text,
      age,
      gender,
      _nationalityController.text,
      _addressController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Personal Information',
          style: TextStyle(
            color: Color(0xFF1A3E74),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      'To create your new account, provide your information.',
                    ),
                    SizedBox(height: 16),

                    // Name
                    Row(
                      children: [
                        CustomText(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        CustomText(
                          '*',
                          style: TextStyle(
                            color: Color(0xFFEF1A26),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _personalNameController,
                      focusNode: _personalNameFocus,
                      keyboardType: TextInputType.text,
                      decoration: context.primaryInputDecoration.copyWith(
                        hintText: TTexts.personalName,
                      ),
                      onFieldSubmitted: (_) => FocusScope.of(
                        context,
                      ).requestFocus(_personalAgeFocus),
                    ),

                    SizedBox(height: 14),

                    // Age
                    Row(
                      children: [
                        CustomText(
                          'Age',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        CustomText(
                          '*',
                          style: TextStyle(
                            color: Color(0xFFEF1A26),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _personalAgeController,
                      focusNode: _personalAgeFocus,
                      keyboardType: TextInputType.number,
                      decoration: context.primaryInputDecoration.copyWith(
                        hintText: TTexts.personalAge,
                      ),
                      onFieldSubmitted: (_) => FocusScope.of(
                        context,
                      ).requestFocus(_nationalityFocus),
                    ),

                    SizedBox(height: 14),

                    // Gender
                    Row(
                      children: [
                        CustomText(
                          'Gender',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        CustomText(
                          '*',
                          style: TextStyle(
                            color: Color(0xFFEF1A26),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      value: gender,
                      items: const [
                        DropdownMenuItem(value: "Male", child: Text("Male")),
                        DropdownMenuItem(
                          value: "Female",
                          child: Text("Female"),
                        ),
                        DropdownMenuItem(value: "Other", child: Text("Other")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFE8ECF1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    SizedBox(height: 14),

                    // Nationality
                    Row(
                      children: [
                        CustomText(
                          'Nationality',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        CustomText(
                          '*',
                          style: TextStyle(
                            color: Color(0xFFEF1A26),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _nationalityController,
                      focusNode: _nationalityFocus,
                      keyboardType: TextInputType.text,
                      decoration: context.primaryInputDecoration.copyWith(
                        hintText: TTexts.nationality,
                        suffixIcon: Icon(Icons.keyboard_arrow_down),
                      ),
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_addressFocus),
                    ),

                    SizedBox(height: 14),

                    // Address
                    Row(
                      children: [
                        CustomText(
                          'Address',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        CustomText(
                          '*',
                          style: TextStyle(
                            color: Color(0xFFEF1A26),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _addressController,
                      focusNode: _addressFocus,
                      keyboardType: TextInputType.text,
                      decoration: context.primaryInputDecoration.copyWith(
                        hintText: TTexts.address,
                      ),
                      onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    ),
                  ],
                ),
              ),
            ),

            // Continue Button
            SizedBox(height: 18),

            // Obx(
            //       () =>  context.primaryButton(
            //     isLoading: _authController.isLoading.value,
            //     onPressed: () {
            //       _submit();
            //     },
            //     text: 'Sign up',
            //   ),
            // ),
            SafeArea(
              child: Obx(
                () => context.primaryButton(
                  isLoading: _authController.isLoading.value,
                  onPressed: _submit,
                  text: 'Continue',
                ),
              ),
            ),
            Gap.h16,
          ],
        ),
      ),
    );
  }
}
