import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/Models/articleModel.dart';

class News {
  List<ArticleModel> news = [];

  Future<List<ArticleModel>> getNews() async {
    const String url =
        "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=e7906ecf1da5434da9727af56c6ee6b4";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var element in jsonData["articles"]) {
        if (element["urlToImage"] != null &&element["description"] != null) {
          ArticleModel article = ArticleModel(
            author: element["author"],
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );

          news.add(article);
        }
      }

      return news;
    } else {
      throw Exception("Failed to load news");
    }
  }
}
