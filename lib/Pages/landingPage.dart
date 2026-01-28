import 'package:flutter/material.dart';
import 'package:newsapp/Pages/home.dart';

class Landingpage extends StatefulWidget {
  const Landingpage({super.key});

  @override
  State<Landingpage> createState() => _LandingpageState();
}

class _LandingpageState extends State<Landingpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadiusGeometry.circular(30),
              elevation: 3,
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(30),
                child: Image.asset("assets/images/building1.jpg",
                height: MediaQuery.of(context).size.height/1.7,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
            SizedBox(height: 30,),
            Text("  Important News from the      \n            World for you",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900
            ),),
            SizedBox(height: 10,),
            Text("Best time to read, take your time to read \n             a little more of this world",style: TextStyle(
              fontSize: 20,
              color: Colors.black45,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 60,),
            Container(
              width:MediaQuery.of(context).size.width/1.2 ,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width:MediaQuery.of(context).size.width/1.2 ,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.blue,
                  ),
                  child: Center(
                    child: TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                    }, child: Text("Get Started",style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),),)
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}