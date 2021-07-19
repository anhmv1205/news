import 'package:get/get.dart';
import 'package:news/core/util/local_storage.dart';
import 'package:news/domain/entities/user.dart';
import 'package:news/domain/usecases/signup_use_case.dart';
import 'package:news/presentation/pages/news/news_page.dart';

class AuthController extends GetxController {
  AuthController(this._loginUseCase);
  final SignUpUseCase _loginUseCase;
  final store = Get.find<LocalStorage>();
  var isLoggedIn = false.obs;

  User? get user => store.user;

  @override
  void onInit() async {
    super.onInit();
    isLoggedIn.value = store.user != null;
  }

  signUpWith(String username) async {
    try {
      final user = await _loginUseCase.execute(username);
      store.user = user;
      isLoggedIn.value = true;
      isLoggedIn.refresh();
    } catch (error) {}
  }

  saveCategory(CategoryType category) async {
    var user = this.user;
    user?.category = category.keyword;
    store.user = user;
  }

  logout() {
    store.user = null;
    isLoggedIn.value = false;
  }
}
