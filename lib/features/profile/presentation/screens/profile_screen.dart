import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/trading_profile_setup_screen.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/upload_profile_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/login_screen.dart';
import 'package:flutter_ladydenily/features/others/about_app_screen.dart';
import 'package:flutter_ladydenily/features/others/privacy_policy_screen.dart';
import 'package:flutter_ladydenily/features/others/refund_policy_screen.dart';
import 'package:flutter_ladydenily/features/others/terms_and_condition_screen.dart';
import 'package:flutter_ladydenily/features/others/video_copyright_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/change_password_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/notification_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/personal_info_screen.dart';
import '../../../video/presentation/screens/video_player_screen.dart';
import '../widgets/profile_option_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          // Handle loading
          if (_profileController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final userInfo = _profileController.userInfo.value;

          // Handle empty data
          if (userInfo == null) {
            return const Center(
              child: Text(
                "No profile data found",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          // Extract avatar safely
          final avatarUrl = userInfo.avatar.url;

          return Column(
            children: [
              const SizedBox(height: 8),

              // Profile Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => UploadProfileScreen(isFromProfile: true));
                      },
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: avatarUrl.isNotEmpty
                                ? NetworkImage(avatarUrl)
                                : const AssetImage(
                                        'assets/images/avatar_placeholder.png',
                                      )
                                      as ImageProvider,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Image.asset(
                                "assets/icons/avater floating.png",
                                width: 16,
                                height: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),

                    // User Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userInfo.name.isNotEmpty
                                ? userInfo.name
                                : "No Name",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            userInfo.address?.isNotEmpty == true
                                ? userInfo.address!
                                : "Unknown Location",
                            style: const TextStyle(
                              color: Color(0xFF4E4E4E),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Options List
              Expanded(
                child: ListView(
                  children: [
                    ProfileOptionTile(
                      iconPath: "assets/icons/personal info.png",
                      title: "Personal Information",
                      onTap: () {
                        Get.to(() => const PersonalInfoScreen());
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/change pass.png",
                      title: "Change Password",
                      onTap: () {
                        Get.to(ChangePasswordScreen());
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/notification.png",
                      title: "Notification Settings",
                      onTap: () {
                        Get.to(() => const NotificationScreen());
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/trading_profile.png",
                      title: 'Trading Profile',
                      onTap: () {
                        Get.to(TradingProfileSetupScreen(isFromProfile: true));
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/about app.png",
                      title: "About App",
                      onTap: () {
                        Get.to(() => const AboutAppScreen());
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/privacy policy.png",
                      title: "Privacy Policy",
                      onTap: () {
                        Get.to(() => const PrivacyPolicyScreen());
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/term.png",
                      title: "Term & Condition",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const TermsAndConditionScreen(),
                          ),
                        );
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/video_copyright.png",
                      title: "Video Copyright",
                      onTap: () {
                        Get.to(() => const VideoCopyrightScreen());
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/Refund_policy.png",
                      title: "Refund Policy",
                      onTap: () {
                        Get.to(() => const RefundPolicyScreen());
                      },
                    ),
                    ProfileOptionTile(
                      iconPath: "assets/icons/logout.png",
                      title: "Logout",
                      iconColor: const Color(0xFFEF1A26),
                      textColor: const Color(0xFFEF1A26),
                      arrowColor: const Color(0xFFEF1A26),
                      onTap: () {
                        Get.offAll(() => const LoginScreen());
                      },
                    ),

                    ProfileOptionTile(
                      iconPath: "assets/icons/term.png",
                      title: "Videos",
                      iconColor: const Color(0xFFEF1AA1),
                      textColor: const Color(0xFFEF1AA1),
                      arrowColor: const Color(0xFFEF1A26),
                      onTap: () {
                        Get.to(() => const VideoPlayerScreen(
                          videoUrl: 'https://filmvideos.s3.us-east-2.amazonaws.com/outputs/uploads/raw/1760499411073-file_example_MOV_1920_2_2MB/1760499411073-file_example_MOV_1920_2_2MB.m3u8',
                        ));
                      },

                    ),

                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
