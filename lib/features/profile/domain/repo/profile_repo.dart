import 'package:dio/dio.dart';
import 'package:flutter_ladydenily/features/profile/data/models/change_password_request_model.dart';

import '../../../../core/network/network_result.dart';
import '../../../auth/data/models/upload_profile_personal_info_response_model.dart';
import '../../data/models/get_profile_response_model.dart';

abstract class ProfileRepository {
  NetworkResult<FetchProfileResponseModel> fetchProfile();

  //profile update
  NetworkResult<UserResponse> updatePersonalInfo(FormData request);

  //Change password
  NetworkResult<void> changePass(ChangePasswordRequest request);

  NetworkResult<UserResponse> uploadPhoto(FormData request);

  NetworkResult<UserResponse> tradingInfo(FormData request);
}
