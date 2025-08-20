import 'package:flutter/material.dart';

import 'cart.dart';

class Foodmenu extends StatefulWidget {
  const Foodmenu({super.key});

  @override
  State<Foodmenu> createState() => _FoodmenuState();
}

class _FoodmenuState extends State<Foodmenu> {

  List menu = [
    {
      "name": "Food",
      "image": "assets/img/menu_1.png",
      "items_count": "120",
    },
    {
      "name": "Beverages",
      "image": "assets/img/menu_2.png",
      "items_count": "220",
    },
    {
      "name": "Desserts",
      "image": "assets/img/menu_3.png",
      "items_count": "155",
    },
    {
      "name": "Promotions",
      "image": "assets/img/menu_4.png",
      "items_count": "25",
    },
  ];



  List dessertsItems= [
    {
      "image": "assets/img/dess_1.png",
      "name": "French Apple Pie",
      "rate": "4.9",
      "rating": "124",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/dess_2.png",
      "name": "Dark Chocolate Cake",
      "rate": "4.9",
      "rating": "124",
      "type": "Cakes by Tella",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/dess_3.png",
      "name": "Street Shake",
      "rate": "4.9",
      "rating": "124",
      "type": "Café Racer",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/dess_4.png",
      "name": "Fudgy Chewy Brownies",
      "rate": "4.9",
      "rating": "124",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/dess_1.png",
      "name": "French Apple Pie",
      "rate": "4.9",
      "rating": "124",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/dess_2.png",
      "name": "Dark Chocolate Cake",
      "rate": "4.9",
      "rating": "124",
      "type": "Cakes by Tella",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/dess_3.png",
      "name": "Street Shake",
      "rate": "4.9",
      "rating": "124",
      "type": "Café Racer",
      "food_type": "Desserts"
    },
    {
      "image": "assets/img/dess_4.png",
      "name": "Fudgy Chewy Brownies",
      "rate": "4.9",
      "rating": "124",
      "type": "Minute by tuk tuk",
      "food_type": "Desserts"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth=MediaQuery.of(context).size.width;
    final screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 248, 240, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 248, 240, 1),
        automaticallyImplyLeading: false,
        title: Text(" Menu",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600),),
        foregroundColor: Color.fromRGBO(255, 248, 240, 1),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
          }, icon: Icon(Icons.add_shopping_cart_rounded,color: Colors.black87,)),
          const SizedBox(width: 10,),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hint: Row(children: [
                    Icon(Icons.search,color: Colors.black54,),
                    const SizedBox(width: 10,),
                    Text("Search Food",style: TextStyle(color: Colors.black54),),
                  ],)
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            child: Stack(
              children:[
                Container(
                  width: 130,
                  height: 500,
                  decoration: BoxDecoration(
                      color: Colors.deepOrange[300],
                      borderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomRight: Radius.circular(50))
                  ),
                ),
                ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: menu.length,
                itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 110,
                    width: double.infinity,
                    child: Stack(
                      clipBehavior: Clip.antiAlias,
                        children:[
                          Center(
                            child: Container(
                              width: 400,
                             // height: 60,
                              decoration: BoxDecoration(
                                  color: Color.fromRGBO(255, 248, 240, 1),
                                  boxShadow: [
                                    BoxShadow(offset: Offset(0, 2),blurRadius: 6,color: Colors.black26),
                                  ],
                                  borderRadius: BorderRadius.horizontal(left: Radius.elliptical(50,50),right: Radius.circular(15))
                              ),
                            ),
                          ),
                          Positioned(
                            top: 25,
                            right: 30,
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(255, 248, 240, 1),
                                  boxShadow: [
                                    BoxShadow(offset: Offset(0, 2),blurRadius: 6,color: Colors.black26),
                                  ],
                                ),
                                child: Image.asset("assets/img/dropdown.png"),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 15,
                            child: Row(
                                children:[ Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(offset: Offset(0, 2),blurRadius: 12,color: Colors.black26),
                                    ],
                                  ),
                                  child: Image.asset(menu[index]["image"]),
                                ),
                                  SizedBox(width: 15,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    spacing: 3,
                                    children: [
                                      Text(menu[index]["name"],style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25),),
                                      Text(menu[index]["items_count"]+" items")
                                    ],
                                  ),

                                ]),
                          )


                        ]),
                  ),
                );
                                },),
            ]),
          ),

        ],
      ),

    );
  }
}
