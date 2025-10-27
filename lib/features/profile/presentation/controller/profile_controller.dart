import 'dart:convert';
import 'dart:io';

import 'package:flutter_ladydenily/core/utils/debug_print.dart';
import 'package:flutter_ladydenily/features/profile/data/models/change_password_request_model.dart';
import 'package:flutter_ladydenily/features/profile/domain/repo/profile_repo.dart';

import 'package:get/get.dart';
import '../../../../core/base/base_controller.dart';
import '../../../../core/network/services/multiple_form_data_manager.dart';
import '../../data/models/get_profile_response_model.dart';

class ProfileController extends BaseController {
  final ProfileRepository _profileRepository;
  var isSkipLoading = false.obs;
  var isContinueLoading = false.obs;
  final MultiFormDataManager _multiFormDataManager = MultiFormDataManager();

  ProfileController(this._profileRepository);

  final Rxn<FetchProfileResponseModel> userInfo = Rxn<
      FetchProfileResponseModel>();
  @override
  void onInit() {
    super.onInit();
    fetchProfile(); //Fetch when controller is created
  }



  Future<void> fetchProfile() async {
    setLoading(true);
    setError("");

    final result = await _profileRepository.fetchProfile();

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log('data fetch failed');
        setLoading(false);
      },
      (success) {
        userInfo.value = success.data;
        DPrint.log(success.message);
        setLoading(false);
      },
    );
  }

  Future<void> updatePersonalInfo(
    String name,
    String age,
    String gender,
    String nationality,
  ) async {
    setLoading(true);
    setError('');

    DPrint.log('Nationality: $nationality');

    _multiFormDataManager.addTextData("name", name);
    _multiFormDataManager.addTextData("age", age);
    _multiFormDataManager.addTextData("gender", gender);
    _multiFormDataManager.addTextData("nationality", nationality);

    final formRequest = await _multiFormDataManager.toFormDataAsync();

    final result = await _profileRepository.updatePersonalInfo(formRequest);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log('Personal info: ${fail.message}');
        isLoading(false);
      },
      (success) async {
        DPrint.log('Personal info: ${success.message}');
        await fetchProfile();
        Get.back();
        isLoading(false);
        setError(success.message);
      },
    );
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    setLoading(true);
    setError('');

    final request = ChangePasswordRequest(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    final result = await _profileRepository.changePass(request);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log("change pass success result : ${fail.message}");
        setLoading(false);
      },
      (success) {
        DPrint.log("change pass success result : ${success.message}");
        Get.back();
        setLoading(false);
      },
    );
  }

  Future<void> uploadPhoto(File image) async {
    setLoading(true);
    setError('');

    _multiFormDataManager.addImageFile(image, key: "avatar");

    final formRequest = await _multiFormDataManager.toFormDataAsync();

    final result = await _profileRepository.uploadPhoto(formRequest);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log('Upload photo: ${fail.message}');
        isLoading(false);
      },
      (success) {
        DPrint.log('Upload photo: ${success.message}');
        fetchProfile();
        Get.back();
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

    _multiFormDataManager.addTextData("treding_profile", toJson);

    final formRequest = await _multiFormDataManager.toFormDataAsync();

    final result = await _profileRepository.tradingInfo(formRequest);

    result.fold(
      (fail) {
        setError(fail.message);
        DPrint.log('Trading info: ${fail.message}');
        isLoading(false);
      },
      (success) {
        DPrint.log('Trading info: ${success.message}');
        Get.back();
        isLoading(false);

        _multiFormDataManager.clear();
        setError(success.message);
      },
    );
  }
}
