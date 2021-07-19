import 'package:news/data/models/paging_model.dart';
import 'package:news/data/providers/network/apis/article_api.dart';
import 'package:news/domain/repositories/article_repository.dart';

class ArticleRepositoryIml extends ArticleRepository {
  @override
  Future<PagingModel> fetchHeadline(int page, int pageSize) async {
    final response = await ArticleAPI.fetchHeadline(page, pageSize).request();
    return PagingModel.fromJson(response);
  }

  @override
  Future<PagingModel> fetchNewsByCategory(
      String keyword, int page, int pageSize) async {
    final response =
        await ArticleAPI.fetchNews(keyword, page, pageSize).request();
    return PagingModel.fromJson(response);
  }
}
