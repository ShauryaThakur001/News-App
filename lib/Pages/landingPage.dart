import 'package:flutter/material.dart';

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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: Image.asset("assets/images/building2.jpg",
              height: MediaQuery.of(context).size.height/1.7,
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              ),
            )
          ],
        ),
      ),
    );
  }
}