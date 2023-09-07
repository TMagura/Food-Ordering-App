import 'package:flutter/material.dart';
import 'package:food_oders/controllers/cart_controller.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:get/get.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {

    //first change to a Map our checked out history list of CartModels
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList();
    Map<String,int> cartItemsPerOrder = Map();

  for (int i = 0; i < getCartHistoryList.length; i++) {
    if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){//we choose time to be our key its Unique
      cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
    }else{
      cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () =>1);
    } 
  }

  //now our data is in a Map we want to check the entries and only take the values but we know the key is jus Time
  //the entries.map((e)=>) is a lop in Maps its an Iterable 
  List<int> cartOrderTimeToList(){
    return cartItemsPerOrder.entries.map((e) => e.value).toList();
  }

  //the values we get from map Iteration gives number of how many items in an Order
  List<int> itemsPerOrder = cartOrderTimeToList();
  var listCounter = 0; //helps wen we use ListView

    return Scaffold(
      body: Column(
        children: [
          //appbar container
          Container(
            width: double.maxFinite,
            height: Dimensions.height20*5,
            color: Colors.green[200],
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BigText(text: "Cart History"),
                Icon(Icons.shopping_cart),
              ],
            ),
          ),
           //the body items to show
           Expanded(
             child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20, 
                right: Dimensions.width20, 
              ),
              child: ListView(
                children: [
                  for(int i =0;i<itemsPerOrder.length;i++) 
                   Container(
                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: "21/sep/2020 10.30AM"),
                      ],
                    ),
                   ),
                  
                ],
              ),
             ),
           ),
       
        ],
      ),
    );
  }
}