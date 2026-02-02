import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Models/articleModel.dart';
import 'package:newsapp/Pages/article_view.dart';
import 'package:newsapp/Services/news.dart';

class AllNews extends StatefulWidget {
  final String news; 

  const AllNews({super.key, required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<ArticleModel> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAllNews();
  }

  Future<void> loadAllNews() async {
    News newsService = News();
    articles = await newsService.getNews(); // pass the selected news/category
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.news.toUpperCase(),
          style: const TextStyle(color: Colors.teal),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return AllNewsTile(
                  imageUrl: article.urlToImage ?? "",
                  title: article.title ?? "No title",
                  desc: article.description ?? "",
                  url: article.url ?? "",
                );
              },
            ),
    );
  }
}

// ================= ALL NEWS TILE =================
class AllNewsTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final String url;

  const AllNewsTile({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (url.isEmpty || !url.startsWith("http")) return;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleView(blogUrl: url),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.broken_image),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(desc),
          ],
        ),
      ),
    );
  }
}
