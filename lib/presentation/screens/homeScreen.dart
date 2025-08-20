import 'package:fastfood_app/application/providers/Providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cart.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {

  List countryFoods = [
    {"image": "assets/img/cat_sri.png", "name": "Sri Lankan"},
    {"image": "assets/img/cat_3.png", "name": "Italian"},
    {"image": "assets/img/cat_4.png", "name": "Indian"},
    {"image": "assets/img/cat_offer.png", "name": "Offers"},
  ];

  List popularRestaurents = [
    {
      "image": "assets/img/res_1.png",
      "name": "Minute by tuk tuk",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/res_2.png",
      "name": "Café de Noir",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
    {
      "image": "assets/img/res_3.png",
      "name": "Bakes by Tella",
      "rate": "4.9",
      "rating": "124",
      "type": "Cafa",
      "food_type": "Western Food"
    },
  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 248, 240, 1),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hy "+ref.watch(userNameProvider)+"!",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.black),),
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                        }, icon:Icon(Icons.shopping_cart)),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Text("Delivering to",style: TextStyle(fontSize: 15,color: Colors.black54),),
                    Row(
                      children: [
                        Text("Current Location",style: TextStyle(color: Colors.black54,fontSize: 20,fontWeight: FontWeight.w600),),
                        SizedBox(width: 30,),
                        SizedBox(
                          child: Image.asset("assets/img/dropdown.png"),
                          height: 15,
                          width: 15,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hint: Row(children: [
                          Icon(Icons.search,color: Colors.black54,),
                          const SizedBox(width: 10,),
                          Text("Search Food",style: TextStyle(color: Colors.black54),)
                        ],)
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                height: 165,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: countryFoods.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    return Padding(
                      padding: EdgeInsets.all(15),
                      child: InkWell(
                        onTap: (){},
                        child: Column(
                          children: [
                            SizedBox(
                              height: 110,
                              width: 110,
                              child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    child: Image.asset(countryFoods[index]["image"]),
                                  ),
                            ),
                            const SizedBox(height: 5,),
                            Text(countryFoods[index]["name"]),
                          ],
                        ),
                      ),
                    );
                    }
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Popular Restaurents",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600,color: Colors.black)),
                    TextButton(onPressed: (){}, child:Text("View all",style: TextStyle(color: Colors.orange[300]),))
                  ],
                ),
              ),
              ListView.builder(itemBuilder: (context,index){
                return InkWell(
                  onTap: (){},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width:double.infinity,
                        height: 200,
                        child: Image.asset(popularRestaurents[index]["image"],fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                              popularRestaurents[index]["name"],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              )
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            SizedBox(
                              child: Image.asset("assets/img/rate.png"),
                              height: 15,
                              width: 15,
                            ),
                            Text(popularRestaurents[index]["rate"]),
                            Text("("+popularRestaurents[index]["rating"]+" ratings)"),
                            Text(popularRestaurents[index]['type']),
                            SizedBox(width: 10,),
                            Text(popularRestaurents[index]["food_type"])
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),

                    ],
                  ),
                );
              },
                itemCount: popularRestaurents.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              )
        
        
            ],
          ),
        ),
      ),
    );
  }
}
