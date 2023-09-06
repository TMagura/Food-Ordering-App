// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_oders/controllers/cart_controller.dart';
import 'package:food_oders/controllers/popular_product_controller.dart';
import 'package:food_oders/pages/cart/cart_page.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:get/get.dart';
import 'package:food_oders/pages/home/main_food_page.dart';
import 'package:food_oders/routes/route_helper.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/app_column.dart';
import 'package:food_oders/widgets/app_icon.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:food_oders/widgets/expandable_text_widget.dart';
import 'package:food_oders/widgets/icon_and_text_widget.dart';
import 'package:food_oders/widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //we use the passed value to have access to our data that is the list in the product controller
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    log("name is = " +product.name.toString());
    //initialise the quantity to be zero
    Get.find<PopularProductController>().initQuantity(product,Get.find<CartController>());

    return Scaffold(
      body:Stack( //a Stack takes up Children since they are 2 or more
        children: [
          //show food image
        Positioned(
          left: 0,
          right: 0,
          child: Container(
            width: double.maxFinite,//this takes all the width
            height: Dimensions.popularFoodImageSize,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!)
                ),
            ),
          ),
          ),
         //shows icons
        Positioned(
         left: Dimensions.width20,
         right: Dimensions.width20,
         top: Dimensions.height45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
            //navigation icons
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getInitial());
              },
              child: AppIcon(icon: Icons.arrow_back_ios,),
              ),
            //cart icon that shows data instantly upon change this is thru state management
            //this state management is facilitated by the getX thru the GetBuilder and the builder uses the controller that will be giving data
            GetBuilder<PopularProductController>(builder: (controller){
              return GestureDetector(
                  onTap: () {
                    if(controller.totalItems>=1) Get.toNamed(RouteHelper.getCartPage());
                    
                  },
                child: Stack(
                  children:[
                   AppIcon(icon: Icons.shopping_cart_checkout_outlined,),
                   //to call the contoller we use Get.find , its different  from how we access models or classes
                   controller.totalItems>1 
                   ?  Positioned(right: 0, top: 0,
                    child: GestureDetector(
                        onTap: () {
                          Get.to(()=>CartPage());
                        },
                        child: AppIcon(
                          icon: Icons.circle,
                          backgroundColor: Colors.black,
                          size: 20,
                          iconColor: Colors.transparent,
                        ),
                      ),
                    )
                   :  Container(),
                   Get.find<PopularProductController>().totalItems>=1
                   ?  Positioned(right: 3, top: 3,
                      child: BigText(text: Get.find<PopularProductController>().totalItems.toString(),size: 12, color: Colors.white, ),
                    )
                  : Container(),
                  ]
                ),
              );
            })
           ],
          ),
          ),
        // shows small details
        Positioned(
          left: 0,
          right: 0,
          bottom:0,
          top:Dimensions.popularFoodImageSize-20,
          child: Container(
            padding: EdgeInsets.only(left:Dimensions.width20, right: Dimensions.width20,top: Dimensions.height20),
           decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight:Radius.circular(Dimensions.radius20),
              topLeft: Radius.circular(Dimensions.radius20),
              ),
            color: Colors.white ,
           ),
           child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppColumn(text:product.name.toString()),
              SizedBox(height: Dimensions.height20,),
              BigText(text: "Food Description"),
              SizedBox(height: Dimensions.height20,),
              Expanded(
                child: SingleChildScrollView(
                  child: ExpandableTextWidget(
                text: product.description!),
                ),
              ),

            ],
           ),
          ),
          ),     
        ],
      ),
        //use the BottomNavigationBar for Add & Dedact from Cart count
      bottomNavigationBar:GetBuilder<PopularProductController>(builder: (popularProduct) {
        return  Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
          top: Dimensions.height20,
          bottom: Dimensions.height20,
          left: Dimensions.width20,
          right: Dimensions.width20,
          ),
          decoration: BoxDecoration( 
            color: Colors.purple[50],
            borderRadius: BorderRadius.only( 
              topLeft: Radius.circular(Dimensions.radius20),
              topRight: Radius.circular(Dimensions.radius20),
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
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
                      popularProduct.setQuantity(false);
                    },
                    child: Icon(Icons.remove, color: Colors.black26,),
                    ),
                  SizedBox(width: (Dimensions.width10),),
                  BigText(text: popularProduct.inCartItems.toString()),
                  SizedBox(width: (Dimensions.width10),),
                  GestureDetector(
                    onTap: (){
                      popularProduct.setQuantity(true);
                    },
                    child: Icon(Icons.add, color: Colors.black26,),
                    ),
                ],
               ),
              ),
              //botomNavigationBar for Cart
            GestureDetector(
              onTap: () {
              popularProduct.addItem(product);
              },
             child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  right: Dimensions.width20/4,
                  left: Dimensions.width20/4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ) ,
                
                  child: BigText(text: "\$ ${product.price!} | Add to Cart",color: Colors.deepPurpleAccent,),
                  
              ),
              ),
            ],
          ),
      );
      },)
    );
  }
}
