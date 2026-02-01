import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/Models/slider_model.dart';

class Sliderssss {
  Future<List<SliderModel>> getSliders() async {
    const String url =
        "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=e7906ecf1da5434da9727af56c6ee6b4";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      List<SliderModel> sliders = [];

      for (var element in jsonData["articles"]) {
        if (element["urlToImage"] != null &&
            element["description"] != null) {
          sliders.add(
            SliderModel(
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

      return sliders;
    } else {
      throw Exception("Failed to load breaking news");
    }
  }
}
