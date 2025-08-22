

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItemQuantityNotifier extends StateNotifier<List<int>>
{
  CartItemQuantityNotifier():super([]);

  int getQuantity(int index)
  {
    return state[index];
  }

  void incrementQuantity(int index)
  {
    dynamic list=[...state];
    list[index]++;
    state=list;
  }
  void decrementQuantity(int index)
  {
    dynamic list=[...state];
    list[index]=list[index]-1;
    state=list;
  }
  void addQuantity()
  {
    state=[...state,1];
  }
  void removeItemQuantity(int index)
  {
    state.removeAt(index);
  }


}