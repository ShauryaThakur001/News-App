import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newsapp/Models/ShowCategory.dart';
import 'package:newsapp/Services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
  final String name;
  const CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCatergoryModel> categories = [];
  bool isLoading = true;

  final ShowCategoryNews showCategoryNews = ShowCategoryNews();

  @override
  void initState() {
    super.initState();
    loadAllData();
  }

  Future<void> loadAllData() async {
    categories = await showCategoryNews.getCategoryNews(widget.name);
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
          widget.name.toUpperCase(),
          style: const TextStyle(color: Colors.teal),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final article = categories[index];
                return ShowCategoryTile(
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

// ================= NEWS TILE =================
class ShowCategoryTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final String url;

  const ShowCategoryTile({
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
        if (url.isEmpty || !url.startsWith("http")) {
          debugPrint("INVALID URL: $url");
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleVieww(blogUrl: url),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(12),
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
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/news_placeholder.png",
                fit: BoxFit.cover,
              ),
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

class ArticleVieww extends StatefulWidget {
  final String blogUrl;

  const ArticleVieww({super.key, required this.blogUrl});

  @override
  State<ArticleVieww> createState() => _ArticleViewwState();
}

class _ArticleViewwState extends State<ArticleVieww> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.blogUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}