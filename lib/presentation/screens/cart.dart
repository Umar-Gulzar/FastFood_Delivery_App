import 'foodMenu.dart';
import 'package:flutter/material.dart';
import 'itemDetail.dart';

//dynamic list=cartItems.toList();

class Cart extends StatefulWidget {
  const Cart({super.key});
  @override
  State<Cart> createState() => _CartState();
}
class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:cartItems.length==0?AppBar(
        automaticallyImplyLeading: false,
        title:InkWell(
          onTap:(){
            Navigator.pop(context);
          },
          child: SizedBox(
              height: 20,
              width: 20,
              child: Image.asset("assets/img/btn_back.png")
          ),
        ),
      ): AppBar(
        backgroundColor: Color.fromRGBO(255, 248, 240, 1),
        automaticallyImplyLeading: false,
        title: Row(
            children: [
              InkWell(
                onTap:(){
                  Navigator.pop(context);
                },
                child: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset("assets/img/btn_back.png")
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width*0.4,),
              Center(
                child: Text("Cart",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,fontSize: 30),
                ),
              )]),
        foregroundColor: Color.fromRGBO(255, 248, 240, 1),
      ),
      backgroundColor:  Color.fromRGBO(255, 248, 240, 1),
      body:cartItems.length==0? Center(
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
      ):
      Container(
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context,index){
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow:[BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 6,
                  color: Colors.black12,
                )],
                color: Color.fromRGBO(255, 248, 240, 1),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(cartItems[index]["image"],fit: BoxFit.cover,),
                                  ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          cartItems[index]["name"],
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Colors.black87,
                          )
                      ),
                      Row(
                        children: [
                          SizedBox(
                            child: Image.asset("assets/img/cash.png"),
                            height: 20,
                            width: 20,
                          ),
                          Text(
                              cartItems[index]["price"],
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.black54,
                              )
                          ),
                        ],
                      ),
                      Card(
                        shadowColor: Colors.black12,
                        elevation: 4,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                        color:Color.fromRGBO(255, 248, 240, 1),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              OutlinedButton(onPressed: (){
                          
                              },
                              child:Text("+",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                              Text(" 2 ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                              OutlinedButton(
                                  onPressed: (){
                          
                                  },
                                  child: Text("-",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                              )
                            ],
                          ),
                        ),
                      )


                    ],
                  ),

                  SizedBox(width: 150,),
                  IconButton(onPressed: (){
                    setState(() {
                      cartItems.removeAt(index);
                    });
                  },
                  icon: Icon(Icons.delete),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
