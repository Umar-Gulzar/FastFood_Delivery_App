import 'package:fastfood_app/presentation/screens/itemDetail.dart';
import 'package:flutter/material.dart';
import 'cart.dart';
import 'foodMenu.dart';

class FavouriteFoods extends StatefulWidget {
  const FavouriteFoods({super.key});

  @override
  State<FavouriteFoods> createState() => _FavouriteFoodsState();
}

class _FavouriteFoodsState extends State<FavouriteFoods> {

  bool isNoFavourite=true;

  @override
  Widget build(BuildContext context) {

    for(int i=0;i < menuItems[0].length;i++)
    {
      if(menuItems[0][i]["isFavourite"]==true)
        isNoFavourite=false;
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 248, 240, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(255, 248, 240, 1),
        automaticallyImplyLeading: false,
        title: Row(
            children: [
              Text("Favourites",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600),
              )]),
        foregroundColor: Color.fromRGBO(255, 248, 240, 1),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
          }, icon: Icon(Icons.add_shopping_cart_rounded,color: Colors.black87,)),
          const SizedBox(width: 10,),
        ],
      ),
      body:isNoFavourite?const Center(child: Text("No Favourite Yet!"),):SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20,),
            ListView.builder(
                shrinkWrap: true,
                itemCount: menuItems[0].length,
                itemBuilder: (context,index){
                  for(int i=0;i < menuItems[0].length;i++)
                  {
                    isNoFavourite=true;
                    if(menuItems[0][i]["isFavourite"]==true)
                      isNoFavourite=false;
                  }
                  if(menuItems[0][index]["isFavourite"]==true) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Stack(
                          children: [ SizedBox(
                              width: double.infinity,
                              height: 200,
                              child: Image.asset(
                                menuItems[0][index]["image"],
                                fit: BoxFit.cover,
                              )
                          ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDetail(selectedItem: menuItems[0][index])));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                            menuItems[0][index]["name"],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Colors.white,
                                            )
                                        )
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            child: Image.asset(
                                                "assets/img/rate.png"),
                                            height: 15,
                                            width: 15,
                                          ),
                                          Text(menuItems[0][index]["rate"],
                                            style: TextStyle(
                                              color: Colors.white,),),
                                          Text(
                                            "(" + menuItems[0][index]["rating"] +
                                                " ratings)", style: TextStyle(
                                            color: Colors.white,),),
                                          Text(menuItems[0][index]['type'],
                                            style: TextStyle(
                                              color: Colors.white,),),
                                          SizedBox(width: 10,),
                                          Text(menuItems[0][index]["food_type"],
                                            style: TextStyle(
                                              color: Colors.white,),)
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                top: 10,
                                right: 10,
                                child: IconButton(
                                  onPressed: () {
                                    if (menuItems[0][index]["isFavourite"] ==
                                        false) {
                                      setState(() {
                                        menuItems[0][index]["isFavourite"] =
                                        true;
                                      });
                                    }
                                    else {
                                      setState(() {
                                        menuItems[0][index]["isFavourite"] =
                                        false;
                                      });
                                    }
                                  },
                                  icon: menuItems[0][index]["isFavourite"]
                                      ? Icon(Icons.favorite, color: Colors.red,)
                                      : Icon(Icons.favorite_border),
                                  color: Colors.white,
                                )
                            ),
                          ]),
                    );
                  }
                  else {
                    return SizedBox.shrink();
                  }
                })
          ],
        ),
      ),

    );
  }
}
