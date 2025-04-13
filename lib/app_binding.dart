// import 'package:get/get.dart';
// import 'app/data/providers/api_provider.dart';
// import 'app/data/repositories/auth_repository.dart';
// import 'app/data/services/auth_service.dart';
// import 'app/data/services/storage_service.dart';

// class AppBinding extends Bindings {
//   @override
//   void dependencies() {
//     // Services
//     Get.putAsync<StorageService>(() => StorageService().init());
//     Get.put<ApiProvider>(ApiProvider());

//     // Repositories
//     Get.put<AuthRepository>(AuthRepository());

//     // Services that depend on Repositories
//     Get.putAsync<AuthService>(() => AuthService().init());
//   }
// }
import 'package:get/get.dart';
import 'app/data/providers/api_provider.dart';
import 'app/data/repositories/auth_repository.dart';
import 'app/data/services/auth_service.dart';
import 'app/data/services/storage_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Services - Create StorageService immediately (not async) to prevent errors
    Get.put<StorageService>(StorageService());

    // Initialize the service after putting it in the dependency injection
    Get.find<StorageService>().init();

    // Now ApiProvider can safely use StorageService since it's already registered
    Get.put<ApiProvider>(ApiProvider());

    // Repositories
    Get.put<AuthRepository>(AuthRepository());

    // Register AuthService immediately
    Get.put<AuthService>(AuthService());

    // Then initialize it
    Get.find<AuthService>().init();
  }
}
