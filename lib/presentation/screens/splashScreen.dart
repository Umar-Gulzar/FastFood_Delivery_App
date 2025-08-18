import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'customerAccountScreen.dart';
import 'bottomNavigationBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  final _currentUser=FirebaseAuth.instance.currentUser; ///To check if user is already logged we take currentUser.

  final userName=TextEditingController();
  final phoneNo=TextEditingController();
  final addr=TextEditingController();

  @override
  void initState() {
    Timer(Duration(seconds: 3),(){
      if(_currentUser==null)  ///If currentUser is null means it is not logged then move to login screen.
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerAccountScreen()));
      else    ///if currentUser is not null means user is already logged then move to home screen.
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigationBarScreen()));
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    userName.dispose();
    phoneNo.dispose();
    addr.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Color.fromRGBO(255, 248, 240, 1),
          child:Container(height: 100,
              width: 100,
              child: Lottie.asset("assets/LottieAnimations/food.json")),
        ),
      ),
    );
  }
}