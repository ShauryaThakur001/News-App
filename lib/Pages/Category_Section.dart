import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  final String name;
  const CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  @override
  Widget build(BuildContext context) {

    Future<void> loadAllData() async {
  
    final categoryService= ShowCategoryNews();

    articles = await newsService.getNews();
    sliders = await sliderService.getSliders();

    setState(() {
      isLoadin = false;
    });
  }
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "News",
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        child: ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  const ShowCategory({super.key, required this.image, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width,
            height: 200,
            fit: BoxFit.cover,
            imageUrl: image,
            ),
            Text(title),
            Text(desc)
        ],
      ),
    );
  }
}
