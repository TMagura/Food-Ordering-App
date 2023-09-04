// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:food_oders/routes/route_helper.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/app_icon.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:food_oders/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  const RecommendedFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView( //this one makes use of slivers which takes a list of widgets
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
                AppIcon(icon: Icons.shopping_cart_checkout_outlined, iconColor: Colors.black),
              ],
            ) ,
            bottom: PreferredSize(
               preferredSize: Size.fromHeight(20),
               child:Container(
                
                child: Center(
                  child: BigText(text:"trymore" , size: Dimensions.fonts20,),
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
              background: Image.asset("assets/images/food4.jpg",width: double.maxFinite,fit: BoxFit.cover,) 
              ),
          ),
         SliverToBoxAdapter(
          child: Column(
            children: [
              //text area with show more or less
              Container(
                margin: EdgeInsets.only(left: Dimensions.width15,  right: Dimensions.width15),
                child:ExpandableTextWidget(
                  text:
            "The machine inscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alterna inscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternati inscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternati inscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternatitiveinscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alterna inscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternati inscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternati inscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternatitiveinscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alterna inscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternati inscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternati inscribes individuals within itsown alternativecribesindividualswithinits own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternativecribes individuals within its own alternatitive",
               ),
              ),
            ],
          ),
         ),
         ],
      ),
      bottomNavigationBar: Column(
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
                 AppIcon(
                  iconSize: Dimensions.iconSize24,
                  icon: Icons.remove,
                  backgroundColor: Colors.blueAccent,
                  iconColor: Colors.black,),
                  BigText(text: "\$ 17.95 " + "  X  " + " 0 "),
                 AppIcon(
                  iconSize: Dimensions.iconSize24,
                  icon: Icons.add,
                  backgroundColor:Colors.blueAccent,
                  iconColor: Colors.black,),
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
              Container(
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
                child: BigText(text: "\$12.85c | Add to Cart",color: Colors.deepPurpleAccent,),
              ),
            ],
          ),
      ),
        ],
      ),
    );
  }
}