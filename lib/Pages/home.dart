import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/Models/catergoryModel.dart';
import 'package:newsapp/Services/data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CatergoryModel> categories = [];

  @override
  void initState() {
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              "news",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    image: categories[index].image,
                    CategoryName: categories[index].categoryName,
                  );
                },
              ),
            ),
            CarouselSlider.builder(
              itemCount: itemCount, 
              itemBuilder: (context, index, realIndex) {
                
              }, 
              options: options)
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final image;
  final CategoryName;
  const CategoryTile({super.key, this.image, this.CategoryName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(6),
            child: Image.asset(
              image,
              width: 120,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 120,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black38,
            ),
            child: Center(child: Text(CategoryName,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),
          ),
        ],
      ),
    );
  }
}
