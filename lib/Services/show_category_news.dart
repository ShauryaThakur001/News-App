import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/Models/ShowCategory.dart';
import 'package:newsapp/Models/catergoryModel.dart';
import 'package:newsapp/Models/slider_model.dart';

class ShowCategoryNews {

  List<ShowCatergoryModel>CategoryNews=[];
  
  Future<List<ShowCatergoryModel>> getCategoryNews(String Category) async {
    final String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=$Category&apiKey=e7906ecf1da5434da9727af56c6ee6b4";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      for (var element in jsonData["articles"]) {
        if (element["urlToImage"] != null &&
            element["description"] != null) {
          CategoryNews.add(
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

      return CategoryNews;
    } else {
      throw Exception("Failed to load breaking news");
    }
  }
}
