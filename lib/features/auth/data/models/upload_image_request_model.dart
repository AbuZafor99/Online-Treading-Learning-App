import 'package:flutter_ladydenily/features/auth/data/models/trading_profile.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';

class UploadImageRequestModel {
  final String? name;
  final int? age;
  final String? phone;
  final String? gender;
  final String? nationality;
  final String? address;
  final TradingProfile? tradingProfile;
  final MultipartFile file; // in case you upload an image/file

  UploadImageRequestModel({
    this.name,
    this.age,
    this.phone,
    this.gender,
    this.nationality,
    this.address,
    this.tradingProfile,
    required this.file,
  });

  Future<FormData> toFormData() async {
    return FormData({
      if (name != null) "name": name,
      if (age != null) "age": age.toString(),
      if (phone != null) "phone": phone,
      if (gender != null) "gender": gender,
      if (nationality != null) "nationality": nationality,
      if (address != null) "address": address,
      if (tradingProfile != null) "treding_profile": tradingProfile,
      "file": file,
    });
  }
}
