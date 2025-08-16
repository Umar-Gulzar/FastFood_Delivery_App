
import 'package:flutter/material.dart';

import 'Screens/splashScreen.dart';


void main()async
{
  runApp(
      MaterialApp(
        title: "Firebase",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple
          ),
        ),
        home:SplashScreen(),
      )
  );
}