import 'package:fastfood_app/Screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customerProfile.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 248, 240, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.pink[300],
          title: Text("Foodies"),
          foregroundColor: Color.fromRGBO(255, 248, 240, 1),
          actions: [
            IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
          }, icon: Icon(Icons.add_shopping_cart_rounded))],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
            items: [
          BottomNavigationBarItem(icon: Icon(Icons.person),label:"Profile",backgroundColor:Colors.pink[300],),
          BottomNavigationBarItem(icon: Icon(Icons.home),label:"Home",backgroundColor:Colors.pink[300],),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu),label:"Menu",backgroundColor:Colors.pink[300],),
          BottomNavigationBarItem(icon: Icon(Icons.favorite),label:"Favourite",backgroundColor:Colors.pink[300],),
        ]),
      ),
    );
  }
}
