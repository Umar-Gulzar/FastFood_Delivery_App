import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fastfood_app/application/providers/Providers.dart';
import 'package:fastfood_app/presentation/screens/itemDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cart.dart';
import 'foodMenu.dart';

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
      body:Consumer(builder: (context,ref,child){
        final data=ref.watch(favouriteListStreamProvider);
        return data.when(
            data: (data){
              return (data.docs.length==0)?const Center(child: Text("No Favourite Yet!"),):SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20,),
                    Consumer(
                        builder: (context,ref,child){
                          final data=ref.watch(favouriteListStreamProvider);
                          return data.when(
                              data: (data){
                                return  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.docs.length,
                                    itemBuilder: (context,index){
                                        return Padding(
                                          padding: EdgeInsets.symmetric(vertical: 10),
                                          child: Stack(
                                              children: [ SizedBox(
                                                  width: double.infinity,
                                                  height: 200,
                                                  child: Image.asset(
                                                    data.docs[index]['image'],
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
                                                                data.docs[index]["name"],
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
                                                              Text(data.docs[index]["rate"],
                                                                style: TextStyle(
                                                                  color: Colors.white,),),
                                                              Text(
                                                                "(" + data.docs[index]["rating"] +
                                                                    " ratings)", style: TextStyle(
                                                                color: Colors.white,),),
                                                              Text(data.docs[index]['type'],
                                                                style: TextStyle(
                                                                  color: Colors.white,),),
                                                              SizedBox(width: 10,),
                                                              Text(data.docs[index]["food_type"],
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
                                                        setState(() {
                                                          ///menuItems[0] list firebase par save nhi iss liya ya karna phara ha taky menushow ma favIcon change ho,
                                                          int itemIndex=menuItems[0].indexWhere((item)=>item["name"]==data.docs[index]["name"]);
                                                          menuItems[0][itemIndex]["isFavourite"]=false;
                                                        });
                                                        String id=data.docs[index]["id"];
                                                        FirebaseFirestore.instance.collection("favourite").doc(id).delete();

                                                      },
                                                      icon: Icon(Icons.favorite, color: Colors.red,),
                                                    )
                                                ),
                                              ]),
                                        );
                                      }
                                    );
                              },
                              error:(e,s){
                                return Text("Error: ${e.toString()}");
                              },
                              loading:(){
                                return const Center(child: CircularProgressIndicator(),);
                              }
                          );
                        }
                    )
                  ],
                ),
              );
            },
            error:(e,s){return Text(e.toString());},
            loading:(){return const CircularProgressIndicator();});
      },)

    );
  }
}
