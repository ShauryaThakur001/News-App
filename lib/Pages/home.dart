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
  List<SliderModel> sliders = [];
  List<ArticleModel> articles = [];

  bool isLoading = true;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    sliders = getSliders();
    fetchNews();
  }

  Future<void> fetchNews() async {
    News newsClass = News();
    articles = await newsClass.getNews();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // 🔹 Categories
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

                // 🔹 Breaking News Title
                sectionHeader("Breaking News!"),

                // 🔹 Carousel Slider
                CarouselSlider.builder(
                  itemCount: sliders.length,
                  itemBuilder: (context, index, realIndex) {
                    final slider = sliders[index];
                    return buildSlider(slider.image!, slider.name!);
                  },
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 10),
                Center(child: buildIndicator()),

                const SizedBox(height: 20),

                // 🔹 Trending News Title
                sectionHeader("Trending News!"),

                // 🔹 News List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];

                    return BlogTile(
                      url: article.url??"",
                      imageUrl: article.urlToImage ?? "",
                      title: article.title ?? "No Title",
                      desc: article.description ?? "",
                    );
                  },
                ),
              ],
            ),
    );
  }

  // 🔹 Section Header Widget
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
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Slider Widget
  Widget buildSlider(String image, String title) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            image,
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
              color: Colors.black38,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            child: Text(
              title,
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

  // 🔹 Indicator
  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: sliders.length,
      effect: const JumpingDotEffect(
        dotWidth: 13,
        dotHeight: 13,
        activeDotColor: Colors.teal,
      ),
    );
  }
}

// 🔹 Category Tile
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

// 🔹 Blog Tile
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogUrl: url)));
      },
      child: Container(
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
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.image_not_supported),
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
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          desc,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
