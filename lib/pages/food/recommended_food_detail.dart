// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_oders/controllers/cart_controller.dart';
import 'package:food_oders/controllers/popular_product_controller.dart';
import 'package:food_oders/controllers/recommended_product_controller.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:get/get.dart';

import 'package:food_oders/routes/route_helper.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/app_icon.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:food_oders/widgets/expandable_text_widget.dart';

class RecommendedFoodDetail extends StatelessWidget {
  int pageID;
  RecommendedFoodDetail({
    Key? key,
    required this.pageID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recommended =Get.find<RecommendedProductController>().recommendedProductList[pageID];
    log(recommended.name!);

    //initialise the quantity to be zero
    Get.find<PopularProductController>().initQuantity(recommended,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      //this CustomScrollView makes use of slivers which takes a list of widgets
      body: CustomScrollView( 
         slivers: [
          //icons on the top 
          SliverAppBar(
            automaticallyImplyLeading: false, 
            toolbarHeight: 80,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.clear, iconColor: Colors.black,),
                  ),
                // AppIcon(icon: Icons.shopping_cart_checkout_outlined, iconColor: Colors.black),
                GetBuilder<PopularProductController>(builder: (controller){
              return GestureDetector(
                onTap: (){
                  if(controller.totalItems>=1)Get.toNamed(RouteHelper.getCartPage());
                },
                child: Stack(
                  children:[
                   AppIcon(icon: Icons.shopping_cart_checkout_outlined,),
                   //to call the contoller we use Get.find , its different  from how we access models or classes
                   controller.totalItems>1 
                   ?  Positioned(right: 0, top: 0,
                    child: AppIcon(icon: Icons.circle, backgroundColor: Colors.black, size:20, iconColor: Colors.transparent,))
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
            ) ,
            //the food name area
            bottom: PreferredSize(
               preferredSize: Size.fromHeight(20),
               child:Container(
                
                child: Center(
                  child: BigText(text:recommended.name! , size: Dimensions.fonts20,),
                  ),
                width: double.maxFinite,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius30),
                    topRight: Radius.circular(Dimensions.radius30),
                    ),
                ) ,
               ),
            ),
            pinned: true,
            backgroundColor: Color.fromARGB(255, 56, 55, 51),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background:Image.network(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommended.img!,
              width: double.maxFinite,fit: BoxFit.cover,) 
              ),
          ),
         SliverToBoxAdapter(
          child: Column(
            children: [
              //text description area with show more or less
              Container(
                margin: EdgeInsets.only(left: Dimensions.width15,  right: Dimensions.width15),
                child:ExpandableTextWidget(
                  text: recommended.description!,
               ),
              ),
            ],
          ),
         ),
         ],
      ),
        // Cart sections with add and substract section
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //add or substract section
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width30,
              right:Dimensions.width30,
              top: Dimensions.width10,
              bottom: Dimensions.width10, 
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 GestureDetector(
                  onTap:() {
                    controller.setQuantity(false);
                  },
                   child: AppIcon(
                    iconSize: Dimensions.iconSize24,
                    icon: Icons.remove,
                    backgroundColor: Colors.blueAccent,
                    iconColor: Colors.black,),
                 ),
                  BigText(text: "\$${recommended.price!}   X  " + "${controller.inCartItems}"),
                 GestureDetector(
                  onTap: () {
                    controller.setQuantity(true);
                  },
                   child: AppIcon(
                    iconSize: Dimensions.iconSize24,
                    icon: Icons.add,
                    backgroundColor:Colors.blueAccent,
                    iconColor: Colors.black,),
                 ),
              ],
            ),
          ),
           //add to cart section
         Container(
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
                  color:  Colors.purple[50],
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ) ,
               child: AppIcon(icon: Icons.favorite, iconSize: Dimensions.iconSize24*2,iconColor:Colors.green[200]! ,)
              ),
              GestureDetector(
                onTap: () {
                  controller.addItem(recommended);
                },
                child:Container(
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
                child: BigText(text: "\$ ${recommended.price} | Add to Cart",color: Colors.deepPurpleAccent,),
              ),
              ),
            ],
          ),
      ),
        ],
      );
      },)
    );
  }
}
