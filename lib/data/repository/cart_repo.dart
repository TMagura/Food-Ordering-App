// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';
import 'dart:developer';

import 'package:food_oders/utils/app_contants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
 final SharedPreferences sharedPreferences;
  CartRepo({
    required this.sharedPreferences,
  });
      
 //create a list that will show what has been checked out before
 List<String> cart=[];
 List<String> cartHistory= [];
 
 //a method that will add string objects to a shared preference which only accept Strings
 void addToCartList(List<CartModel> cartList){
  cart=[];
  var time = DateTime.now().toString();
  cartList.forEach((element) {
    element.time = time;
    //convert objects to String using the jsonEncode
    return cart.add(jsonEncode(element));
  });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //test results after adding.
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));

    // getCartList();

 }

 //a method to fetch data stored in a shared preference list and that data is in form of ob
 List<CartModel> getCartList(){
  List<String> carts = [];
  if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
    carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    print("cartlists"+carts.toString());
  }
  List<CartModel> cartList = [];
  carts.forEach((element) {
    cartList.add(CartModel.fromJson(jsonDecode(element)));
  });

  return cartList; 
 }

    //check is the data is stored successfully in the shared pref fot cartHistory
    List<CartModel> getCartHistorylist(){
      if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
        cartHistory=[];
        cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
      }
      List<CartModel> cartListHistory = [];
      cartHistory.forEach((element)=>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
      return cartListHistory;
    }

  //we loop to see how many items are in the cart wen we check out so that the history can be generated
  //its a2 phase thing as we save data before checkout and after checkout
  void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
       cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    for(int i =0;i<cart.length;i++){
      print("history is"+cart[i]);
      cartHistory.add(cart[i]);
    }

     removeCart();
    //store data to be accesed in the history page alone
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
    print("history length is "+getCartHistorylist().length.toString());
    for (int i = 0; i < getCartHistorylist().length; i++) {
      print("the time is"+getCartHistorylist()[i].time.toString());
    }
    
  }
  //remove cart data  stored in shared pref after checkout so that next time you open up nothing is in cart
  void removeCart(){
    cart=[];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }


}
