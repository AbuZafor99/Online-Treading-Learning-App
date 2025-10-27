import 'package:flutter_ladydenily/features/auth/data/models/trading_profile.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

import 'different_user_model.dart';

class PersonalInfoRequestFormModel {
  final String name;
  final int age;

  final String gender;
  final String nationality;
  final String address;
  final TradingProfile? tradingProfile;
  final MultipartFile? file; // in case you upload an image/file

  PersonalInfoRequestFormModel({
    required this.name,
    required this.age,
    required this.gender,
    required this.nationality,
    required this.address,
    this.tradingProfile,
    this.file,
  });

  Future<FormData> toFormData() async {
    return FormData({
      "name": name,
      "age": age.toString(),
      "gender": gender,
      "nationality": nationality,
      "address": address,
      if (tradingProfile != null) "treding_profile": tradingProfile,
      if (file != null) "file": file,
    });
  }
}
