import 'package:news/presentation/pages/news/news_page.dart';
import 'package:collection/collection.dart';

class User {
  User({this.username, this.category});

  String? username;
  String? category;

  CategoryType? get type {
    return CategoryType.values
        .firstWhereOrNull((element) => element.keyword == category);
  }

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      username: json?['username'] as String?,
      category: json?['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'category': category,
      };
}
