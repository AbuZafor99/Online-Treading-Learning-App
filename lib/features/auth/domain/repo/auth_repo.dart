import 'package:dio/dio.dart';

import '../../../../core/network/network_result.dart';
import '../../data/models/auth_response_model.dart';
import '../../data/models/login_request_model.dart';
import '../../data/models/otp_request_model.dart';
import '../../data/models/otp_request_model_register.dart';
import '../../data/models/refresh_token_request_model.dart';
import '../../data/models/refresh_token_response_model.dart';
import '../../data/models/register_request_model.dart';
import '../../data/models/register_response_model.dart';
import '../../data/models/reset_password_request_model.dart';
import '../../data/models/set_new_password_request_model.dart';
import '../../data/models/upload_profile_personal_info_response_model.dart';
import '../../data/models/user_model.dart';

abstract class AuthRepository {
  NetworkResult<AuthResponseModel> login(LoginRequestModel request);
  NetworkResult<RegisterResponseModel> register(RegisterRequestModel request);
  NetworkResult<void> otpVerifyRegister(OtpRequestModelRegister request);
  NetworkResult<UserResponse> personalInfo(FormData request);
  NetworkResult<UserResponse> uploadPhoto(FormData request);
  NetworkResult<UserResponse> tradingInfo(FormData request);
  NetworkResult<void> resetPassword(ResetPasswordRequestModel request);
  NetworkResult<void> resetOtpVerify(OtpVerificationRequestModel request);
  NetworkResult<void> setNewPassword(SetNewPasswordRequestModel request);
  NetworkResult<RefreshTokenResponseModel> refreshToken(
    RefreshTokenRequestModel request,
  );

  NetworkResult<UserModel> getUserProfile();
}
