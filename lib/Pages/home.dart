import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Models/articleModel.dart';
import 'package:newsapp/Models/catergoryModel.dart';
import 'package:newsapp/Models/slider_model.dart';
import 'package:newsapp/Pages/article_view.dart';
import 'package:newsapp/Services/data.dart';
import 'package:newsapp/Services/news.dart';
import 'package:newsapp/Services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CatergoryModel> categories = [];
  List<ArticleModel> articles = [];
  List<SliderModel> sliders = [];

  bool isLoading = true;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    loadAllData();
  }

  Future<void> loadAllData() async {
    final newsService = News();
    final sliderService = Sliderssss();

    articles = await newsService.getNews();
    sliders = await sliderService.getSliders();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              "News",
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // ================= CATEGORIES =================
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 10),
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        image: categories[index].image!,
                        categoryName: categories[index].categoryName!,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                sectionHeader("Breaking News"),

                // ================= BREAKING NEWS SLIDER =================
                CarouselSlider.builder(
                  itemCount: sliders.length,
                  itemBuilder: (context, index, realIndex) {
                    final slider = sliders[index];
                    return buildSlider(
                      slider.urlToImage!,
                      slider.title!,
                    );
                  },
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() => activeIndex = index);
                    },
                  ),
                ),

                const SizedBox(height: 10),
                Center(child: buildIndicator()),

                const SizedBox(height: 20),

                sectionHeader("Trending News"),

                // ================= TRENDING NEWS LIST =================
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return BlogTile(
                      imageUrl: article.urlToImage ?? "",
                      title: article.title ?? "No title",
                      desc: article.description ?? "",
                      url: article.url ?? "",
                    );
                  },
                ),
              ],
            ),
    );
  }

  // ================= SECTION HEADER =================
  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Text(
            "View All",
            style: TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }

  // ================= SLIDER ITEM =================
  Widget buildSlider(String image, String title) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ================= INDICATOR =================
  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: sliders.length,
      effect: const JumpingDotEffect(
        dotHeight: 12,
        dotWidth: 12,
        activeDotColor: Colors.teal,
      ),
    );
  }
}

// ================= CATEGORY TILE =================
class CategoryTile extends StatelessWidget {
  final String image;
  final String categoryName;

  const CategoryTile({
    super.key,
    required this.image,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              image,
              width: 120,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black38,
            ),
            child: Center(
              child: Text(
                categoryName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= BLOG TILE =================
class BlogTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String desc;
  final String url;

  const BlogTile({
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
        if (url.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticleView(blogUrl: url),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        desc,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
