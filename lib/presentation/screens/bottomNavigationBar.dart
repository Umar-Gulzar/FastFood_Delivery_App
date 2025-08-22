import 'cart.dart';
import 'customerAccountScreen.dart';
import 'favouriteFoods.dart';
import 'foodMenu.dart';
import 'homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'customerProfile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {

  int _selectedIndex=1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 248, 240, 1),
        bottomNavigationBar: CurvedNavigationBar(
          animationCurve: Curves.easeOutBack,
          index: 1,
          color: Colors.deepOrange.shade300,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.deepOrange[300],
          items: <Widget>[
            Icon(Icons.person, size: 30,color: Colors.white,),
            Icon(Icons.home, size: 30,color: Colors.white,),
            Icon(Icons.restaurant_menu, size: 30,color: Colors.white,),
            Icon(Icons.favorite, size: 30,color: Colors.white,),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex=index;
            });
          },
        ),

        body: IndexedStack(
          index:_selectedIndex,
          children: [Profile(),Homescreen(),Foodmenu(),FavouriteFoods()],
        ),
      ),
    );
  }
}
