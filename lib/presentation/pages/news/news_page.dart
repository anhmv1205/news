import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/presentation/controllers/auth/auth_controller.dart';
import 'package:news/presentation/controllers/news/news_controller.dart';
import 'package:news/presentation/pages/detail/detail_page.dart';
import 'package:news/presentation/pages/headline/views/article_cell.dart';
import 'package:visibility_detector/visibility_detector.dart';

enum CategoryType { bitcoin, apple, earthquake, animal }

extension CategoryKeyword on CategoryType {
  String get keyword {
    switch (this) {
      case CategoryType.bitcoin:
        return "bitcoin";
      case CategoryType.apple:
        return "apple";
      case CategoryType.earthquake:
        return "earthquake";
      case CategoryType.animal:
        return "animal";
    }
  }
}

class NewsPage extends StatefulWidget {
  @override
  _NewsPagePage createState() => _NewsPagePage();
}

class _NewsPagePage extends State<NewsPage> {
  final NewsController newsController = Get.find();
  final AuthController authController = Get.find();
  final _scrollController = ScrollController();
  CategoryType _currentCategory = CategoryType.bitcoin;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('NewsPage'),
      onVisibilityChanged: (visibilityInfo) {
        final visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage == 100.0) {
          _currentCategory = authController.user?.type ?? CategoryType.bitcoin;
        }
        newsController.fetchData(_currentCategory.keyword);
      },
      child: GetX(
        init: newsController,
        initState: (state) {
          _currentCategory = authController.user?.type ?? CategoryType.bitcoin;
        },
        didUpdateWidget: (old, newState) {
          _scrollController.addListener(_scrollListener);
        },
        dispose: (state) {
          _scrollController.removeListener(_scrollListener);
        },
        builder: (_) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('News'),
              trailing: TextButton(
                  onPressed: () {
                    _selectCategory(context);
                  },
                  child: Text(_currentCategory.keyword.capitalizeFirst ?? "")),
            ),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: newsController.articles.length,
              itemBuilder: (context, index) {
                final article = newsController.articles[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => DetailPage(article: article));
                  },
                  child: ArticleCell(article: article),
                );
              },
            ),
          );
        },
      ),
    );
  }

  _selectCategory(BuildContext context) {
    final actions = CategoryType.values
        .map(
          (e) => CupertinoActionSheetAction(
            child: Text(e.keyword.capitalizeFirst ?? ""),
            onPressed: () {
              setState(() {
                _currentCategory = e;
              });
              newsController.fetchData(e.keyword);
              authController.saveCategory(e);
              Navigator.pop(context);
            },
          ),
        )
        .toList();

    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Select category'),
        actions: actions,
      ),
    );
  }

  _scrollListener() {
    if (_scrollController.position.extentAfter < 500) {
      newsController.loadMore(_currentCategory.keyword);
    }
  }
}
