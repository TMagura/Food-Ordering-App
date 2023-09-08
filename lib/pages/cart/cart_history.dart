import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_oders/base/no_data_page.dart';
import 'package:food_oders/controllers/cart_controller.dart';
import 'package:food_oders/models/cart_model.dart';
import 'package:food_oders/routes/route_helper.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:food_oders/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {

    //first change to a Map our checked out history list of CartModels and sort them by time/jus reverse
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
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
  List<int> cartItemsPerOrderToList(){
    return cartItemsPerOrder.entries.map((e) => e.value).toList();
  }

  //the values we get from map Iteration gives number of how many items in an Order
  List<int> itemsPerOrder = cartItemsPerOrderToList();

    List<String> cartOrderTimeToList(){
    return cartItemsPerOrder.entries.map((e) => e.key).toList();
  }
  var listCounter = 0; //helps wen we use ListView

  //create a widget to calculate the unique time
   Widget timeWidget(int index){
    var dateOutput = DateTime.now.toString();
    //first we create an object of the actual date
    if (index < getCartHistoryList.length){
    var actualDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
    var dateFormat = DateFormat("MM/dd/yyyy hh:mm a");
    dateOutput = dateFormat.format(actualDate);
    }
    return BigText(text: dateOutput, size: 16, color: Colors.blueGrey,);
   }

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
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().length>0
            ?  Expanded(
             child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height10/5,
                left: Dimensions.width20, 
                right: Dimensions.width20, 
              ),
              child:MediaQuery.removePadding(context: context, 
              child:ListView(
                children: [
                  for(int i =0;i<itemsPerOrder.length;i++) 
                   Container(
                    height: Dimensions.height20*6,
                    margin: EdgeInsets.only(bottom: Dimensions.height20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [  
                        timeWidget(listCounter),
                        SizedBox(height: Dimensions.height10/2,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // this is a wrapper with pics
                            Wrap(
                              children: List.generate(itemsPerOrder[i], (index){
                                if(listCounter < getCartHistoryList.length){
                                 listCounter++;
                                }
                               return index <= 1
                                ?  Container(
                                    height: Dimensions.height20*4, 
                                    width: Dimensions.width20*4,
                                    margin: EdgeInsets.only(right: 5,), 
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!) )
                                      ),
                                  )
                               :  Container();
                              } ),
                            ),
                            //right text show item number
                            Container(
                              height: Dimensions.height45*2, 
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SmallText(text: "Total"),
                                  BigText(text: itemsPerOrder[i].toString()+" Items", color:Colors.blueAccent,),
                                  GestureDetector(
                                    onTap: (){
                                     var orderTime = cartOrderTimeToList();
                                     Map<int ,CartModel> moreOrders = {};
                                     for(int z=0; z<getCartHistoryList.length;z++){
                                      if(getCartHistoryList[z].time == orderTime[i]){
                                        //when the time is the same for item list and  the content
                                        moreOrders.putIfAbsent(getCartHistoryList[z].id!, () => 
                                        CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[z])))
                                        );
                                      }
                                     }
                                     Get.find<CartController>().setItems = moreOrders;
                                     Get.find<CartController>().addTocartList();
                                     Get.toNamed(RouteHelper.getCartPage());
                                    } ,
                                    child: Container(
                                      padding: EdgeInsets.all(Dimensions.height10),
                                      decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(Dimensions.radius15/2),
                                        border: Border.all(width: 1,color: Colors.orange),
                                      ),
                                      child: SmallText(text: "do more"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 1, color: Colors.blueGrey,),
                      ],
                    ),
                   ),
                  
                ],
              ),
              ), 
             ),
           )

        : Container(
          height: MediaQuery.of(context).size.height/1.5,
          child: const  Center(
            child: NoDataPage(text: "No History Yet",),
          ),
        );


          })
       



        ],
      ),
    );
  }
}