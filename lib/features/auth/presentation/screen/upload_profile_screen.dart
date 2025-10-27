import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/trading_profile_setup_screen.dart';
import 'package:flutter_ladydenily/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

class UploadProfileScreen extends StatefulWidget {
  const UploadProfileScreen({super.key, required this.isFromProfile});

  final bool isFromProfile;

  @override
  State<UploadProfileScreen> createState() => _UploadProfileScreenState();
}

class _UploadProfileScreenState extends State<UploadProfileScreen> {
  File? _pickedImage; // store picked image
  final ImagePicker _picker = ImagePicker();
  final _authController = Get.find<AuthController>();
  final _profileController = Get.find<ProfileController>();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  void _submit() async {
    // === Navigation logic depends on source ===
    if (widget.isFromProfile) {
      // If opened from profile, go back to ProfileScreen
      _profileController.uploadPhoto(
        _pickedImage!,
      ); // just pop back to ProfileScreen
    } else {
      await _authController.uploadPhoto(_pickedImage!);
    }
  }

  void _skip() {
    if (widget.isFromProfile) {
      // If opened from profile, just go back
      Get.back();
    } else {
      // Otherwise go to next onboarding step
      Get.to(() => const TradingProfileSetupScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Profile',
          style: TextStyle(
            color: Color(0xFF1A3E74),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("To create your new account, provide one of your photos."),

            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF1A3E74),
                          width: 8,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: screenWidth / 3,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: _pickedImage != null
                            ? FileImage(_pickedImage!)
                            : null,
                        child: _pickedImage == null
                            ? const Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.grey,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () => _pickImage(ImageSource.camera),
                          label: const Text(
                            'Camera',
                            style: TextStyle(color: Color(0xFF1A3E74)),
                          ),
                        ),
                        const SizedBox(width: 16),

                        TextButton.icon(
                          onPressed: () => _pickImage(ImageSource.gallery),
                          label: const Text(
                            'Photos',
                            style: TextStyle(color: Color(0xFF1A3E74)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => context.secondaryButton(
                      isLoading: widget.isFromProfile
                          ? _profileController.isSkipLoading.value
                          : _authController.isSkipLoading.value,
                      height: 51,
                      borderColor: AppColors.buttonColor,
                      width: (screenWidth / 2) - 32,
                      onPressed: () {
                        widget.isFromProfile
                            ? _profileController.isSkipLoading.value = true
                            : _authController.isSkipLoading.value = true;
                        _skip();
                      },
                      text: "Skip",
                      borderRadius: 8,
                    ),
                  ),
                  const SizedBox(width: 8),

                  Obx(
                    () => context.primaryButton(
                      isLoading: widget.isFromProfile
                          ? _profileController.isLoading.value
                          : _authController.isLoading.value,
                      width: (screenWidth / 2) - 32,
                      height: 51,
                      onPressed: () {
                        _submit();
                      },
                      text: "Continue",
                      borderRadius: 8,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
