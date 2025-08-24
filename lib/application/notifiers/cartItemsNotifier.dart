import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItemsNotifier extends StateNotifier<List<Map<String,dynamic>>>
{
  CartItemsNotifier():super([]);

  void addCartItem({dynamic value})
  {
    dynamic list=[...state];
    list.add(value);
    state=list;
  }
  void removeCartItem(int index)
  {
    dynamic list=[...state];
    list.removeAt(index);
    state=list;
  }
  Map<String,dynamic> getCartItem(int index)
  {
    return state[index];
  }
  void setFavourite(int index,bool v)
  {
    dynamic list=[...state];
    list[index]["isFavourite"]=v;
    state=list;
  }
  int getLength()
  {
    return state.length;
  }
  String getImage(int index)
  {
    return state[index]["image"];
  }
  int getPrice(int index)
  {
    return int.parse(state[index]["price"]);
  }
  String getName(int index)
  {
    return state[index]["name"];
  }
  String getDescription(int index)
  {
    return state[index]["description"];
  }
  String getRate(int index)
  {
    return state[index]["rate"];
  }
  String getRating(int index)
  {
    return state[index]["rating"];
  }
  String getType(int index)
  {
    return state[index]["type"];
  }
  String getFoodType(int index)
  {
    return state[index]["food_type"];
  }

}