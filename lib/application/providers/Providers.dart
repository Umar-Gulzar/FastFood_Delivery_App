import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNameProvider=StateProvider<String>((ref)=>"user");
final phoneNoProvider=StateProvider<String>((ref)=>"");
final addressProvider=StateProvider<String>((ref)=>"current address");
final imageProvider=StateProvider<File?>((ref)=>null);