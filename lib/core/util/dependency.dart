import 'package:get/get.dart';
import 'package:news/data/repositories/auth_repository.dart';
import 'package:news/data/repositories/article_repository.dart';

class DenpendencyCreator {
  static init() {
    Get.lazyPut(() => AuthenticationRepositoryIml());
    Get.lazyPut(() => ArticleRepositoryIml());
  }
}
