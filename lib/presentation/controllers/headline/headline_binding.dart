import 'package:get/get.dart';
import 'package:news/data/repositories/article_repository.dart';
import 'package:news/domain/usecases/fetch_headline_use_case.dart';
import 'package:news/presentation/controllers/headline/headline_controller.dart';

class HeadlineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FetchHeadlineUseCase(Get.find<ArticleRepositoryIml>()));
    Get.lazyPut(() => HeadlineController(Get.find()));
  }
}
