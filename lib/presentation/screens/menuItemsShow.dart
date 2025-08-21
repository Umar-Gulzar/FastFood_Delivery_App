import 'package:flutter/material.dart';
import 'cart.dart';

class MenuItemsShow extends StatefulWidget {
  List<dynamic> menuList;
  MenuItemsShow({required this.menuList});

  @override
  State<MenuItemsShow> createState() => _MenuItemsShowState();
}

class _MenuItemsShowState extends State<MenuItemsShow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 248, 240, 1),
      appBar: AppBar(
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
          SizedBox(width: 10,),
          Text(" "+widget.menuList[0]['food_type'],style: TextStyle(color: Colors.black87,fontWeight: FontWeight.w600),
        )]),
        foregroundColor: Color.fromRGBO(255, 248, 240, 1),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
          }, icon: Icon(Icons.add_shopping_cart_rounded,color: Colors.black87,)),
          const SizedBox(width: 10,),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
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
            ListView.builder(
            shrinkWrap: true,
            itemCount: widget.menuList.length,
            itemBuilder: (context,index){
              return Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                children:[ SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.asset(
                  widget.menuList[index]["image"],
                  fit: BoxFit.cover,
                )
                ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                                widget.menuList[index]["name"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white,
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
                              Text(widget.menuList[index]["rate"],style: TextStyle(color: Colors.white,),),
                              Text("("+widget.menuList[index]["rating"]+" ratings)",style: TextStyle(color: Colors.white,),),
                              Text(widget.menuList[index]['type'],style: TextStyle(color: Colors.white,),),
                              SizedBox(width: 10,),
                              Text(widget.menuList[index]["food_type"],style: TextStyle(color: Colors.white,),)
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                      ],
                    ),
                  ),
                  Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    onPressed: (){
                      if(widget.menuList[index]["isFavourite"]==false) {
                        setState(() {
                          widget.menuList[index]["isFavourite"] = true;
                        });}
                      else {
                        setState(() {
                          widget.menuList[index]["isFavourite"] = false;
                        });
                      }
                    },
                    icon:widget.menuList[index]["isFavourite"]?Icon(Icons.favorite,color: Colors.red,): Icon(Icons.favorite_border),
                    color: Colors.white,
                  )
                  ),
              ]),
              );
            })
          ],
        ),
      ),

    );
  }
}
