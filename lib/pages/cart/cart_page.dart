import 'package:flutter/material.dart';
import 'package:food_oders/controllers/cart_controller.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/app_icon.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:food_oders/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //top icons at appbar
          Positioned(
            top: Dimensions.height20*3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //back icon
              AppIcon(
                icon: Icons.arrow_back,
                iconColor: Colors.white,
                backgroundColor: Colors.black38,
                size: Dimensions.iconSize24*1.5,      
              ),
              SizedBox(width: Dimensions.width30*4,),
              //home icon
              AppIcon(
                icon: Icons.home_outlined,
                iconColor: Colors.white,
                backgroundColor: Colors.black38,
                size: Dimensions.iconSize24*1.5,      
              ),
              //cart icon
              AppIcon(
                icon: Icons.shopping_cart,
                iconColor: Colors.white,
                backgroundColor: Colors.black38,
                size: Dimensions.iconSize24*1.5,      
              ),
            ],
          ),
          ),
          //listview of items
          Positioned(
            top: Dimensions.height20*5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              color: Colors.black12,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController){
                  return  ListView.builder(
                    itemCount: cartController.getItems.length,
                    itemBuilder: (_,index){
                     return Container(
                
                      height: 100,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(bottom: 10,top: Dimensions.height15),
                      child: Row(
                        children: [
                          //image container
                          Container(
                            width: Dimensions.height20*5,
                            height: Dimensions.height20*5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!),
                                fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.blueAccent,
                            ),
                          ),
                           SizedBox(width: Dimensions.width10,),
                           //text column
                           Expanded(child: Container(
                            height: Dimensions.height20*5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BigText(text: cartController.getItems[index].name!),
                                SmallText(text: "spicy hot",),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(text: "\$${cartController.getItems[index].price!}", color: Colors.redAccent,),
                            
                                // plus and minus icons
                                Container(
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                    bottom: Dimensions.height10,
                                    right: Dimensions.width10,
                                    left: Dimensions.width10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                  ) ,
                                  // this is the left counter
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // popularProduct.setQuantity(false);
                                      },
                                      child: Icon(Icons.remove, color: Colors.black26,),
                                      ),
                                    SizedBox(width: (Dimensions.width10),),
                                    BigText(text:"0"),// popularProduct.inCartItems.toString()),
                                    SizedBox(width: (Dimensions.width10),),
                                    GestureDetector(
                                      onTap: (){
                                        // popularProduct.setQuantity(true);
                                      },
                                      child: Icon(Icons.add, color: Colors.black26,),
                                      ),
                                      ],
                                    ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                           ),),
                        ],
                      ),
                     );
                  });
                  }
                ),
              ),
            ),
           ),
        ],
      ),
    );
  }
}