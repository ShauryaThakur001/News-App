import 'package:flutter/material.dart';
import 'package:newsapp/Models/catergoryModel.dart';
import 'package:newsapp/Services/data.dart';

class Home extends StatefulWidget {
  
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CatergoryModel>categories=[];

  @override
  void initState() {
    categories=getCategories();
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
            Text("Flutter",),
            Text("news",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    image: categories[index].image,
                    CategoryName: categories[index].categoryName,
                  );
              },),
            )
          ],
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
    return Stack(
      children: [
        Image.asset(image,width: 120,height: 60,fit: BoxFit.cover,)
      ],
    );
  }
}