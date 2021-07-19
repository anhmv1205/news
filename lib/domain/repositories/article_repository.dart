import 'package:news/data/models/paging_model.dart';

abstract class ArticleRepository {
  Future<PagingModel> fetchHeadline(int page, int pageSize);
  Future<PagingModel> fetchNewsByCategory(
      String keyword, int page, int pageSize);
}
