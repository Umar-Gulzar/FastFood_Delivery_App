import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 350,
            child: Stack(
              children: [
                Container(
                  color: Colors.red,
                height: 300,
                width: double.infinity,
                child: Icon(Icons.image),),
                Positioned(
                  right: 15,
                  top: 280,
                  child: CircleAvatar(
                    backgroundColor: Colors.pink[300],
                    child: IconButton(onPressed: (){

                    }, icon: Icon(Icons.edit,color: Colors.white,)),
                  ),
                )
            ],
            ),
          ),

          SizedBox(height: 100,),
          ListTile(
            title: Text("username"),
          ),
          ListTile(
            title: Text("Phone"),
          ),
          ListTile(
            title: Text("Address"),
          ),
        ],
      ),
    );
  }
}
