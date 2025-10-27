import 'package:flutter_ladydenily/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/controllers/module_controller.dart';
import 'package:flutter_ladydenily/features/course_content/presentation/controllers/module_details_controller.dart';
import 'package:flutter_ladydenily/features/search/presentation/controllers/search_controller.dart'
    as search;
import 'package:get/get.dart';

import '../../features/auth/presentation/controller/auth_controller.dart';
import 'package:flutter_ladydenily/features/course/presentation/controllers/course_controller.dart';
import 'package:flutter_ladydenily/features/course/domain/course_repository.dart';
import 'package:flutter_ladydenily/features/home/presentation/controllers/trainer_controller.dart';
import 'package:flutter_ladydenily/features/home/domain/trainer_repository.dart';
import 'package:flutter_ladydenily/features/marketplace/presentation/controllers/marketplace_controller.dart';
import 'package:flutter_ladydenily/features/marketplace/domain/marketplace_repository.dart';
import 'package:flutter_ladydenily/features/community/presentation/controllers/community_controller.dart';
import 'package:flutter_ladydenily/features/community/domain/community_repository.dart';

void setupController() {
  // Auth Controller
  Get.lazyPut<AuthController>(
    fenix: true,
    () => AuthController(Get.find(), Get.find()),
  );
  Get.lazyPut<ProfileController>(
    fenix: true,
    () => ProfileController(Get.find()),
  );

  // Course Content Controllers
  Get.lazyPut<ModuleController>(
    fenix: true,
    () => ModuleController(Get.find()),
  );
  Get.lazyPut<ModulesDetailsController>(
    fenix: true,
    () => ModulesDetailsController(Get.find()),
  );

  Get.lazyPut<CourseController>(
    fenix: true,
    () => CourseController(repository: Get.find<CourseRepository>()),
  );
  Get.lazyPut<TrainerController>(
    fenix: true,
    () => TrainerController(repository: Get.find<TrainerRepository>()),
  );
  Get.lazyPut<MarketplaceController>(
    fenix: true,
    () => MarketplaceController(repository: Get.find<MarketplaceRepository>()),
  );
  Get.lazyPut<CommunityController>(
    fenix: true,
    () => CommunityController(repository: Get.find<CommunityRepository>()),
  );
  Get.lazyPut<search.SearchController>(() => search.SearchController());
}
