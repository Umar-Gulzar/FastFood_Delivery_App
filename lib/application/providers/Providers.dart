import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _auth=FirebaseAuth.instance;

final userNameProvider=StateProvider<String>((ref)=>"user");
final phoneNoProvider=StateProvider<String>((ref)=>"");
final addressProvider=StateProvider<String>((ref)=>"current address");

final imageProvider=StateProvider<File?>((ref)=>null);
final loginLoadingProvider=StateProvider<bool>((ref)=>false);
final signupLoadingProvider=StateProvider<bool>((ref)=>false);


///jab streamProvider sy firestore ka data access kary gy tu async* aur yield nhi lagana simple return karwana.
final customerStreamProvider=StreamProvider((ref){
  return FirebaseFirestore.instance.collection("customer").where('creator',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();
});