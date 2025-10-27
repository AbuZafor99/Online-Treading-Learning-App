import 'package:flutter_ladydenily/features/community/data/community_repository_impl.dart';
import 'package:flutter_ladydenily/features/community/domain/community_repository.dart';
import 'package:flutter_ladydenily/features/course/data/course_repository_impl.dart';
import 'package:flutter_ladydenily/features/course/domain/course_repository.dart';
import 'package:flutter_ladydenily/features/home/data/trainer_repository_impl.dart';
import 'package:flutter_ladydenily/features/home/domain/trainer_repository.dart';
import 'package:flutter_ladydenily/features/marketplace/data/marketplace_repository_impl.dart';
import 'package:flutter_ladydenily/features/marketplace/domain/marketplace_repository.dart';
import 'package:flutter_ladydenily/features/profile/data/repo/profile_repo_impl.dart';
import 'package:flutter_ladydenily/features/profile/domain/repo/profile_repo.dart';
import 'package:get/get.dart';

import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/domain/repo/auth_repo.dart';

void setupRepository() {
  Get.lazyPut<AuthRepository>(
    fenix: true,
    () => AuthRepositoryImpl(apiClient: Get.find()),
  );
  Get.lazyPut<ProfileRepository>(
    fenix: true,
    () => ProfileRepositoryImpl(apiClient: Get.find()),
  );
  Get.lazyPut<CourseRepository>(
    fenix: true,
    () => CourseRepositoryImpl(apiClient: Get.find()),
  );
  Get.lazyPut<TrainerRepository>(
    fenix: true,
    () => TrainerRepositoryImpl(apiClient: Get.find()),
  );
  Get.lazyPut<MarketplaceRepository>(
    fenix: true,
    () => MarketplaceRepositoryImpl(apiClient: Get.find()),
  );
  Get.lazyPut<ProfileRepository>(
    fenix: true,
    () => ProfileRepositoryImpl(apiClient: Get.find()),
  );
  Get.lazyPut<CommunityRepository>(
    fenix: true,
    () => CommunityRepositoryImpl(apiClient: Get.find()),
  );
}
