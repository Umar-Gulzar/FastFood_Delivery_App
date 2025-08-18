import 'foodMenu.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromRGBO(255, 248, 240, 1),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Icon(Icons.shopping_cart_outlined,size: 200,),
            const SizedBox(height: 40,),
            Text("Your cart is empty",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            const SizedBox(height: 20,),
            Text(textAlign: TextAlign.center,"Looks like you haven't made"),
            Text(textAlign: TextAlign.center,"your menu yet."),
            const SizedBox(height: 50,),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                child: Text("Back to Menu",style: TextStyle(color: Colors.white),)),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
