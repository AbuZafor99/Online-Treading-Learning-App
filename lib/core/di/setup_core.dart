import 'package:get/get.dart';

import '../network/api_client.dart';
import '../network/services/auth_storage_service.dart';

void setupCore() {
  Get.lazyPut<ApiClient>(() => ApiClient());

  Get.lazyPut<AuthStorageService>(() => AuthStorageService());
}
