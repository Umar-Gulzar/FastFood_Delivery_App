import 'package:fastfood_app/application/providers/Providers.dart';
import 'package:fastfood_app/presentation/screens/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemDetail extends ConsumerWidget{
  Map<String,dynamic> selectedItem;
  ItemDetail({super.key,required this.selectedItem});
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 248, 240, 1),
      body: Column(
        children: [
          Stack(
            children:[ SizedBox(
              height: 350,
              width: double.infinity,
              child: Image.asset(selectedItem["image"],fit: BoxFit.cover,),
            ),
            Positioned(
              top: 30,
              left: 20,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: SizedBox(child: Image.asset("assets/img/btn_back.png",color: Colors.white,),height: 20,width: 20,),
              ),
            ),
              Positioned(
                top: 30,
                right: 20,
                child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
                }, icon: Icon(Icons.add_shopping_cart_rounded,color: Colors.white,)),
              )
            ],
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    selectedItem["name"],
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: Colors.black87,
                    )
                ),

                Row(
                  children: [
                    SizedBox(
                      child: Image.asset("assets/img/rate.png"),
                      height: 15,
                      width: 15,
                    ),
                    Text(selectedItem["rate"],style: TextStyle(color: Colors.black87,),),
                    Text("("+selectedItem["rating"]+" ratings)",style: TextStyle(color: Colors.black87,),),
                    Text(selectedItem['type'],style: TextStyle(color: Colors.black87,),),
                    SizedBox(width: 10,),
                    Text(selectedItem["food_type"],style: TextStyle(color: Colors.black87,),)
                  ],
                ),
                const SizedBox(height:15,),
                Text(
                    selectedItem["description"],
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize: 20,
                    )
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    Text("Price: ",style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black54,
                    ),),
                    SizedBox(
                      child: Image.asset("assets/img/cash.png"),
                      height: 20,
                      width: 20,
                    ),
                    Text(
                        selectedItem["price"],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.black54,
                        )
                    ),
                  ],
                ),


              ],
            ),
          ),
          const SizedBox(height: 50,),
          SizedBox(
            width: 180,
            child: ElevatedButton(onPressed: (){
                ref.read(cartItemsProvider.notifier).addCartItem(value: selectedItem);
                ref.read(cartItemQuantity.notifier).addQuantity();
            },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.add_shopping_cart,color: Colors.white,),
                    Text("Add to Cart",style: TextStyle(color: Colors.white),),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
