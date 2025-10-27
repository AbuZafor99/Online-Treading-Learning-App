import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/constants/api_constants.dart';
import '../../../../core/network/network_result.dart';
import '../../../auth/data/models/upload_profile_personal_info_response_model.dart';
import '../../domain/repo/profile_repo.dart';
import '../models/change_password_request_model.dart';
import '../models/get_profile_response_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ApiClient _apiClient;

  ProfileRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  NetworkResult<FetchProfileResponseModel> fetchProfile() {
    return _apiClient.get(
        ApiConstants.user.getUserProfile,
        fromJsonT: (json) =>
            FetchProfileResponseModel.fromJson(json as Map<String, dynamic>));
  }

  @override
  NetworkResult<UserResponse> updatePersonalInfo(FormData request) {
    return _apiClient.patch(
      ApiConstants.user.updateProfile,
      formData: request,
      fromJsonT: (json) => UserResponse.fromJson(json),
      isFormData: true,
    );
  }

  @override
  NetworkResult<void> changePass(ChangePasswordRequest request) {
    return _apiClient.post(
      ApiConstants.auth.changePassword,
      data: request.toJson(),
      fromJsonT: (json) => [],
    );
  }

  @override
  NetworkResult<UserResponse> uploadPhoto(FormData request) {
    return _apiClient.patch(
      ApiConstants.user.updateProfile,
      formData: request,
      fromJsonT: (json) => UserResponse.fromJson(json),
      isFormData: true,
    );
  }

  @override
  NetworkResult<UserResponse> tradingInfo(FormData request) {
    return _apiClient.patch(
      ApiConstants.user.updateProfile,
      formData: request,
      fromJsonT: (json) => UserResponse.fromJson(json),
      isFormData: true,
    );
  }
}
