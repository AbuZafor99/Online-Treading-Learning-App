import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/constants/api_constants.dart';
import '../../../../core/network/network_result.dart';
import '../../domain/repo/auth_repo.dart';
import '../models/auth_response_model.dart';
import '../models/login_request_model.dart';
import '../models/otp_request_model.dart';
import '../models/otp_request_model_register.dart';
import '../models/refresh_token_request_model.dart';
import '../models/refresh_token_response_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import '../models/reset_password_request_model.dart';
import '../models/set_new_password_request_model.dart';
import '../models/upload_profile_personal_info_response_model.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  NetworkResult<AuthResponseModel> login(LoginRequestModel request) {
    return _apiClient.post<AuthResponseModel>(
      ApiConstants.auth.login,
      data: request.toJson(),
      fromJsonT: (json) => AuthResponseModel.fromJson(json),
      // isFormData: true
    );
  }

  @override
  NetworkResult<RegisterResponseModel> register(RegisterRequestModel request) {
    return _apiClient.post<RegisterResponseModel>(
      ApiConstants.auth.register,
      data: request.toJson(),
      fromJsonT: (json) => RegisterResponseModel.fromJson(json),
    );
  }

  @override
  NetworkResult<void> resetPassword(ResetPasswordRequestModel request) {
    return _apiClient.post(
      ApiConstants.auth.resetPass,
      data: request.toJson(),
      fromJsonT: (json) => [],
    );
  }

  @override
  NetworkResult<void> resetOtpVerify(OtpVerificationRequestModel request) {
    return _apiClient.post(
      ApiConstants.auth.otpVerify,
      data: request.toJson(),
      fromJsonT: (json) => [],
    );
  }

  @override
  NetworkResult<void> otpVerifyRegister(OtpRequestModelRegister request) {
    return _apiClient.post(
      ApiConstants.auth.otpVerifyRegister,
      data: request.toJson(),
      fromJsonT: (json) => [],
    );
  }

  @override
  NetworkResult<UserResponse> personalInfo(FormData request) {
    return _apiClient.patch(
      ApiConstants.user.updateProfile,
      formData: request,
      fromJsonT: (json) => UserResponse.fromJson(json),
      isFormData: true,
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

  @override
  NetworkResult<void> setNewPassword(SetNewPasswordRequestModel request) {
    return _apiClient.post(
      ApiConstants.auth.setNewPass,
      data: request.toJson(),
      fromJsonT: (json) => [],
    );
  }

  @override
  NetworkResult<RefreshTokenResponseModel> refreshToken(
    RefreshTokenRequestModel request,
  ) {
    return _apiClient.post(
      ApiConstants.auth.refreshToken,
      data: request.toJson(),
      fromJsonT: (json) => RefreshTokenResponseModel.fromJson(json),
    );
  }

  @override
  NetworkResult<UserModel> getUserProfile() {
    return _apiClient.get<UserModel>(
      ApiConstants.user.getUserProfile,
      fromJsonT: (json) => UserModel.fromJson(json),
    );
  }
}
