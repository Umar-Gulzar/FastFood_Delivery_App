import 'dart:async';

import 'package:flutter/material.dart';

import 'loginScreen.dart';






class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //final _currentUser=FirebaseAuth.instance.currentUser; ///To check if user is already logged we take currentUser.

  @override
  void initState() {

    Timer(Duration(seconds: 2),(){
     // if(_currentUser==null)  ///If currentUser is null means it is not logged then move to login screen.
        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
     // else    ///if currentUser is not null means user is already logged then move to home screen.
      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageUpload()));
    });

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(
        child: const Text("Fast Food",style: TextStyle(color: Colors.black,fontSize: 30),),
      ),
    );
  }
}