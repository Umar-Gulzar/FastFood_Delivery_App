import 'package:fastfood_app/Screens/cart.dart';
import 'package:fastfood_app/Screens/customerAccountScreen.dart';
import 'package:fastfood_app/Screens/favouriteFoods.dart';
import 'package:fastfood_app/Screens/foodMenu.dart';
import 'package:fastfood_app/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customerProfile.dart';


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
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            setState(() {
              _selectedIndex=index;
            });
          },
          currentIndex: _selectedIndex,
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.person),label:"Profile",backgroundColor:Colors.deepOrange[300],),
          BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home",backgroundColor:Colors.deepOrange[300],),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu),label:"Menu",backgroundColor:Colors.deepOrange[300],),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label:"Favourite",backgroundColor:Colors.deepOrange[300],),
        ]),
        body: IndexedStack(
          index:_selectedIndex,
          children: [Profile(),Homescreen(),Foodmenu(),FavouriteFoods()],
        ),
      ),
    );
  }
}
