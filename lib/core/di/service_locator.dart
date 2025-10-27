import 'set_controllers.dart';
import 'setup_core.dart';
import 'setup_repository.dart';
import 'setup_services.dart';

void setupServiceLocator() {
  // Core Services
  setupCore();

  // Repositories
  setupRepository();

  // Use Cases

  // Controllers
  setupController();

  // Services
  setupServices();
}
