import 'package:get/get.dart';
import 'package:news/data/repositories/auth_repository.dart';
import 'package:news/domain/usecases/signup_use_case.dart';
import 'package:news/presentation/controllers/auth/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpUseCase(Get.find<AuthenticationRepositoryIml>()));
    Get.put(AuthController(Get.find()), permanent: true);
  }
}
