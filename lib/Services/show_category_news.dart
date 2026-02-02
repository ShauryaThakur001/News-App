import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/Models/ShowCategory.dart';

class ShowCategoryNews {
  List<ShowCatergoryModel> categoryNews = [];

  Future<List<ShowCatergoryModel>> getCategoryNews(String category) async {
    categoryNews.clear();

    final String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=e7906ecf1da5434da9727af56c6ee6b4";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var element in jsonData["articles"]) {
        final imageUrl = element["urlToImage"];

        if (imageUrl != null &&
            imageUrl.toString().startsWith("http") &&
            element["description"] != null) {
          categoryNews.add(
            ShowCatergoryModel(
              author: element["author"],
              title: element["title"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"],
            ),
          );
        }
      }

      return categoryNews;
    } else {
      throw Exception("Failed to load category news");
    }
  }
}
