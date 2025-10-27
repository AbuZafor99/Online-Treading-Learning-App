// import 'package:flutter/material.dart';
// import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
// import 'package:get/get.dart';
// import '../../../../core/network/services/secure_store_services.dart';
// import '../controller/auth_controller.dart';
//
// class AccountPreviewScreen extends StatefulWidget {
//   const AccountPreviewScreen({super.key});
//
//   @override
//   State<AccountPreviewScreen> createState() => _AccountPreviewScreenState();
// }
//
// class _AccountPreviewScreenState extends State<AccountPreviewScreen> {
//   final _authController = Get.find<AuthController>();
//
//   // Make email and password observable
//   final RxString email = ''.obs;
//   final RxString  password = ''.obs;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSavedCredentials();
//   }
//
//   Future<void> _loadSavedCredentials() async {
//     final SecureStoreServices secureStoreServices = SecureStoreServices();
//     // final secureStore = SecureStoreServices();
//     email.value = await secureStoreServices.retrieveData("email") ?? '';
//     password.value = await secureStoreServices.retrieveData("password") ?? '';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (email.isEmpty || password.isEmpty) {
//         // fallback if data is not found
//         return const Scaffold(
//           body: Center(child: CircularProgressIndicator()),
//         );
//       }
//
//       return Scaffold(
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Avatar placeholder
//               SizedBox(
//                 height: 143,
//                 width: 143,
//                 child: const CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage('assets/icons/avatar.jpg'),
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               Text(
//                 email.value,
//                 style: const TextStyle(fontSize: 18, color: Colors.white),
//               ),
//               const SizedBox(height: 10),
//
//               // Hidden password
//               Text(
//                 '*' * password.value.length,
//                 style: const TextStyle(fontSize: 18, letterSpacing: 3, color: Colors.white),
//               ),
//               const SizedBox(height: 30),
//
//           // AccountPreviewScreen (only showing the relevant part)
//
//           Obx(() => context.primaryButton(
//             isLoading: _authController.isLoading.value,
//             onPressed: () async {
//               final secureStore = SecureStoreServices();
//
//               // store a flag that user has confirmed this account preview
//               await secureStore.storeData('previewConfirmed', 'true');
//
//               // use existing RememberMeController if present, otherwise create one
//               final rememberMeCtrl = Get.isRegistered<RememberMeController>()
//                   ? Get.find<RememberMeController>()
//                   : Get.put(RememberMeController());
//
//               // call login (your login already stores credentials when rememberMe is true)
//               await _authController.login(
//                 rememberMeCtrl,
//                 email: email.value,
//                 password: password.value,
//               );
//
//               // login might already navigate; if not, you can safely navigate here:
//
//                 Get.offAll(() => const HomeScreen());
//             },
//             text: "This is your account",
//           )),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
