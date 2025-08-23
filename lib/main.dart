import 'package:flutter/material.dart';
import 'presentation/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main()async
{
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey="pk_test_51RyytjCjTfzItJpubU8s4OX1EU0d2fAteb8p15bYcgVMXk7UDVFaFlgyuKf2oGqFVJ9AxhSThK28We55buzJKSZQ00Fa3BUpTW";
  Stripe.merchantIdentifier="apple_pay";  //it is required to use apple pay in sheet.
  await Stripe.instance.applySettings();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ProviderScope(
        child: MaterialApp(
          title: "FastFood",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor:Colors.deepOrange,
            ),
          ),
          home:SplashScreen(),
        ),
      )
  );
}