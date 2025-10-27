import 'dart:convert';
import 'dart:io';
import 'package:flutter_ladydenily/core/network/services/multiple_form_data_manager.dart';
import 'package:flutter_ladydenily/features/auth/data/models/trading_profile.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/create_new_password_screen.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/personal_information_screen.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/trading_profile_setup_screen.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/upload_profile_screen.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/verify_code_screen.dart';
import 'package:flutter_ladydenily/features/auth/presentation/screen/verify_otp_to_register.dart';
import 'package:flutter_ladydenily/features/others/terms_and_disclaimer_dialog_screen.dart';
import 'package:flutter_ladydenily/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutx_core/flutx_core.dart';
import 'package:get/get.dart';
import '../../../../core/base/base_controller.dart';
import '../../../../core/network/services/auth_storage_service.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/otp_request_model.dart';
import '../../data/models/otp_request_model_register.dart';
import '../../data/models/refresh_token_request_model.dart';
import '../../data/models/register_request_model.dart';
import '../../data/models/reset_password_request_model.dart';
import '../../data/models/set_new_password_request_model.dart';
import '../../domain/repo/auth_repo.dart';
import '../screen/login_screen.dart';

class AuthController extends BaseController {
  final AuthRepository _authRepository;
  final AuthStorageService _authStorageService;
  bool _isSuccess = false;
  var isSkipLoading = false.obs;
  var isContinueLoading = false.obs;

  AuthController(this._authRepository, this._authStorageService);

  final MultiFormDataManager _multiFormDataManager = MultiFormDataManager();

  // Login
  Future<void> login(String email, String password) async {
    setLoading(true);
    setError("");

    final request = LoginRequestModel(email: email, password: password);

    final result = await _authRepository.login(request);

    DPrint.log("Login Response ${result.isRight()}");

    // _multiFormDataManager.addTextData("name", email);
    // _multiFormDataManager.toFormData();
    //
    // _multiFormDataManager.clear();

    result.fold(
      (fail) {
        setError(fail.message);
        setLoading(false);
      },
      (success) async {
        final user = success.data.user;
        await _authStorageService.storeAuthData(
          accessToken: success.data.accessToken!,
          refreshToken: success.data.refreshToken!,
          userId: success.data.user!.id!,
        );
        Get.to(() => HomeScreen());
        setLoading(false);
      },
    );
  }

  Future<void> register(String name, String email, String password) async {
    setLoading(true);
    setError('');

    final request = RegisterRequestModel(
      name: name,
      email: email,
      password: password,
    );

    final result = await _authRepository.register(request);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log("Register success result : ${fail.message}");
        setLoading(false);
      },
      (success) async {
        DPrint.log("Register success result : ${success.data.name}");
        await _authStorageService.storeAuthData(
          accessToken: success.data.accessToken,
          refreshToken: success.data.refreshToken,
          userId: success.data.id,
        );
        Get.to(() => OtpVerificationToCompleteRegister(email: email));
        setLoading(false);
      },
    );
  }

  Future<void> personalInfo(
    String name,
    int age,
    String gender,
    String nationality,
    String address,
  ) async {
    setLoading(true);
    setError('');

    _multiFormDataManager.addTextData("name", name);
    _multiFormDataManager.addTextData("age", age.toString());
    _multiFormDataManager.addTextData("gender", gender);
    _multiFormDataManager.addTextData("national", nationality);
    _multiFormDataManager.addTextData("address", address);

    final formRequest = await _multiFormDataManager.toFormDataAsync();

    final result = await _authRepository.personalInfo(formRequest);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log('Personal info: ${fail.message}');
        isLoading(false);
      },
      (success) {
        DPrint.log('Personal info: ${success.message}');
        Get.to(() => UploadProfileScreen(isFromProfile: false));
        isLoading(false);
        setError(success.message);
      },
    );
  }

  Future<void> uploadPhoto(File image) async {
    setLoading(true);
    setError('');

    _multiFormDataManager.addImageFile(image, key: "avatar");

    final formRequest = await _multiFormDataManager.toFormDataAsync();

    final result = await _authRepository.uploadPhoto(formRequest);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log('Upload photo: ${fail.message}');
        isLoading(false);
      },
      (success) {
        DPrint.log('Upload photo: ${success.message}');
        Get.to(() => TradingProfileSetupScreen(isFromProfile: false));
        setError(success.message);
        _multiFormDataManager.clear();
        isLoading(false);
      },
    );
  }

  Future<void> tradingProfileSetup(
    final String tradingExperience,
    final String assetsOfInterest,
    final String mainGoal,
    final String riskAppetite,
    final List<String> preferredLearning,
  ) async {
    setLoading(true);
    setError('');

    final profile = TradingProfile(
      tradingExperience: tradingExperience,
      assetsOfInterest: assetsOfInterest,
      mainGoal: mainGoal,
      riskAppetite: riskAppetite,
      preferredLearning: preferredLearning,
    );
    final toJson = jsonEncode(profile.toJson());

    // _multiFormDataManager.addTextData("tradingExperience", tradingExperience);
    // _multiFormDataManager.addTextData("assetsOfInterest", assetsOfInterest);
    // _multiFormDataManager.addTextData("mainGoal", mainGoal);
    // _multiFormDataManager.addTextData("riskAppetite", riskAppetite);

    _multiFormDataManager.addTextData("treding_profile", toJson);

    final formRequest = await _multiFormDataManager.toFormDataAsync();

    final result = await _authRepository.tradingInfo(formRequest);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log('Trading info: ${fail.message}');
        isLoading(false);
      },
      (success) {
        DPrint.log('Trading info: ${success.message}');
        isLoading(false);
        Get.to(() => HomeScreen());
        _multiFormDataManager.clear();
        setError(success.message);
      },
    );
  }

  Future resetPass(String email) async {
    setLoading(true);
    setError('');

    final request = ResetPasswordRequestModel(email: email);
    final result = await _authRepository.resetPassword(request);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log("reset pass success result : ${fail.message}");
        setLoading(false);
      },
      (success) {
        DPrint.log("reset pass success result : ${success.message}");
        Get.offAll(() => VerifyCodeScreen(email: email));
        setLoading(false);
      },
    );
  }

  // Future resendOTP(String email) async {
  //   setLoading(true);
  //   setError("");
  //
  //   final request = ResetPasswordRequestModel(email: email);
  //   final result = await _authRepository.resetPassword(request);
  //
  //   result.fold(
  //     (fail) {
  //       setError(fail.message);
  //       DPrint.log("reset pass success result : ${fail.message}");
  //       setLoading(false);
  //     },
  //     (success) {
  //       DPrint.log("reset pass success result : ${success.data.message}");
  //       Get.snackbar("OTP Sent", "We have resent the OTP to $email");
  //       setLoading(false);
  //     },
  //   );
  // }

  Future verifyOTP(String email, String otp) async {
    setLoading(true);
    setError("");

    final request = OtpVerificationRequestModel(email: email, otp: otp);
    final result = await _authRepository.resetOtpVerify(request);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log("verify otp success result : ${fail.message}");
        setLoading(false);
      },
      (success) {
        DPrint.log("verify otp success result : ${success.message}");
        Get.to(() => CreateNewPasswordScreen(email: email, otp: otp));
        setLoading(false);
      },
    );
  }

  Future verifyOTPRegister(String email, String otp) async {
    setLoading(true);
    setError("");

    DPrint.log('otp check $email $otp');

    final request = OtpRequestModelRegister(email: email, otp: otp);
    final result = await _authRepository.otpVerifyRegister(request);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log("verify otp success result : ${fail.message}");
        setLoading(false);
      },
      (success) {
        DPrint.log("verify otp success result : ${success.message}");
        Get.to(
          () => TermsAndDisclaimerDialogScreen(
            onAgree: () {
              Get.to(() => PersonalInformationScreen());
            },
          ),
        );
        setLoading(false);
      },
    );
  }

  Future setNewPass(String email, String otp, String newPassword) async {
    setLoading(true);
    setError("");

    final request = SetNewPasswordRequestModel(
      email: email,
      otp: otp,
      password: newPassword,
    );
    final result = await _authRepository.setNewPassword(request);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log("New Password set failed result : ${fail.message}");
        setLoading(false);
      },
      (success) {
        DPrint.log("New Password set successfully result : ${success.message}");
        Get.to(() => LoginScreen());
        setLoading(false);
      },
    );
  }

  Future refreshToken() async {
    setLoading(true);

    final refreshToken = await _authStorageService.getRefreshToken();
    DPrint.log("Got refresh token: $refreshToken");
    final request = RefreshTokenRequestModel(refreshToken: refreshToken);

    final result = await _authRepository.refreshToken(request);

    final navi = result.fold(
      (fail) {
        DPrint.log("Refresh token failed: ${fail.message}");
        setLoading(false);
        return _isSuccess = false;
      },
      (success) async {
        DPrint.log("Refresh token success: ${success.message}");
        await _authStorageService.storeAccessToken(success.data.accessToken);
        await _authStorageService.storeRefreshToken(success.data.refreshToken);
        // _authStorageService.clearAuthData();
        setLoading(false);
        return _isSuccess = true;
      },
    );
    return navi;
  }

  Future<void> logout() async {
    await _authStorageService.clearAuthData();
    Get.offAll(() => LoginScreen());
  }
}
