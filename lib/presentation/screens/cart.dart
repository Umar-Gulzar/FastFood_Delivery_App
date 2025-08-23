import 'package:fastfood_app/Services/stripePaymentSheet.dart';
import 'package:fastfood_app/application/providers/Providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'foodMenu.dart';
import 'package:flutter/material.dart';
import 'itemDetail.dart';

class Cart extends ConsumerStatefulWidget{
  const Cart({super.key});
  @override
  ConsumerState<Cart> createState() => _CartState();
}
class _CartState extends ConsumerState<Cart> {

  double totalPrice=0;
  double singleItemPrice=0;

  @override
  void ConsumerinitState(WidgetRef ref) {
    int length=ref.watch(cartItemsProvider).length;
    int quan;
    for(int index=0;index<length;index++)
    {
      double price=ref.watch(cartItemsProvider.notifier).getPrice(index);
        totalPrice=totalPrice+price;
    }
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var length = ref.watch(cartItemsProvider).length;

    return Scaffold(
      appBar:length==0?AppBar(
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
              SizedBox(width: MediaQuery.of(context).size.width*0.35,),
              Center(
                child: Text("Cart",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600,fontSize: 30),
                ),
              )]),
        foregroundColor: Color.fromRGBO(255, 248, 240, 1),
      ),
      backgroundColor:  Color.fromRGBO(255, 248, 240, 1),
      body:length==0? Center(
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
      SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width:MediaQuery.of(context).size.width,
          child: Column(
            children:[
              const SizedBox(height: 20,),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                  itemCount:length,
                  itemBuilder: (context,index){

                    String name=ref.watch(cartItemsProvider.notifier).getName(index);
                    String image=ref.watch(cartItemsProvider.notifier).getImage(index);
                    double price=ref.watch(cartItemsProvider.notifier).getPrice(index);

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
                        child: Image.asset(image,fit: BoxFit.cover,),
                                      ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              name,
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
                                  price.toString(),
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
                              child: Consumer(
                                builder: (context,ref,child){
                                  int quantity=ref.watch(cartItemQuantity.notifier).getQuantity(index);
                                  return Row(
                                    children: [
                                      OutlinedButton(onPressed: (){
                                        ref.read(cartItemQuantity.notifier).incrementQuantity(index);
                                        setState(() {
                                          singleItemPrice=price;
                                          totalPrice=totalPrice+singleItemPrice;
                                        });
                                      },
                                          child:Text("+",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                                      Text(" ${quantity} ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                                      OutlinedButton(
                                          onPressed: (){
                                              if(quantity>1) {
                                                ref.read(cartItemQuantity.notifier).decrementQuantity(index);
                                                singleItemPrice=price;
                                                setState(() {
                                                  totalPrice=totalPrice-singleItemPrice;
                                                });
                                              }
                                          },
                                          child: Text("-",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          )

                        ],
                      ),
                      Spacer(),
                      IconButton(onPressed: (){
                        setState(() {
                          singleItemPrice=price*ref.watch(cartItemQuantity.notifier).getQuantity(index);
                          totalPrice=totalPrice-singleItemPrice;
                        });
                        ref.read(cartItemsProvider.notifier).removeCartItem(index);
                        ref.read(cartItemQuantity.notifier).removeItemQuantity(index);
                      },
                      icon: Icon(Icons.delete),
                      )
                    ],
                  ),
                ),
              );
                      }),
           Spacer(),
            SizedBox(
              width: 180,
              child: ElevatedButton(onPressed: (){
                makePayment(context,10, "Uae");
              },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                child: Row(
                    children:[
                      Text("Pay: ",style: TextStyle(color: Colors.white,fontSize: 20),),
                      Text("\$ ",style: TextStyle(color: Colors.black,fontSize: 20),),
                      Text("${totalPrice.toStringAsFixed(2)}",style: TextStyle(color: Colors.white,fontSize: 20),)
                ]),
                  ),
            ),
              SizedBox(height: 120,),
              ]),
        ),
      )
      );
  }
}
