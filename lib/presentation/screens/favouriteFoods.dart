import 'package:flutter/material.dart';

class FavouriteFoods extends StatefulWidget {
  const FavouriteFoods({super.key});

  @override
  State<FavouriteFoods> createState() => _FavouriteFoodsState();
}

class _FavouriteFoodsState extends State<FavouriteFoods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 248, 240, 1),
      body: Center(child: Text("No Favourite Yet",style: TextStyle(fontWeight: FontWeight.w400),),),
    );
  }
}
