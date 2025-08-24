import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fastfood_app/application/notifiers/cartItemsNotifier.dart';
import 'package:fastfood_app/application/notifiers/cartItemQuantityNotifier.dart';

final _auth=FirebaseAuth.instance;

final imageProvider=StateProvider<File?>((ref)=>null);
final loginLoadingProvider=StateProvider<bool>((ref)=>false);
final signupLoadingProvider=StateProvider<bool>((ref)=>false);


///jab streamProvider sy firestore ka data access kary gy tu async* aur yield nhi lagana simple return karwana.
final customerStreamProvider=StreamProvider((ref){
  return FirebaseFirestore.instance.collection("customer").where('creator',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();
});

final totalPriceProvider=StateProvider((ref)=>0);


final cartItemsProvider=StateNotifierProvider<CartItemsNotifier,List<Map<String,dynamic>>>((ref){
  return CartItemsNotifier();
});

final cartItemQuantity=StateNotifierProvider<CartItemQuantityNotifier,List<int>>((ref){
  return CartItemQuantityNotifier();
});