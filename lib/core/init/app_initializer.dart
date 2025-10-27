import 'package:flutter/widgets.dart';

import '../di/service_locator.dart';
import 'hive_intialization.dart';
// import '../services/socket_service.dart';
// import 'hive_intialization.dart';

class AppInitializer {
  static Future<void> initializeApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    await HiveInitialization.initHive();

    setupServiceLocator();

    // SocketService.initializeSocket(sl());
  }
}
