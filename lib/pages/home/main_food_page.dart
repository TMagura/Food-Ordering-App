// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_oders/pages/home/food_page_body.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:food_oders/widgets/small_text.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[ 
          //the appdar with search Icon
          Container(
          child: Container(
            margin: EdgeInsets.only(top: 45, bottom: 15),
            padding: EdgeInsets.only(left: 20,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    BigText(text:'Zimbabwe',color: Color.fromARGB(255, 53, 204, 61),),
                    Row(
                      children: [
                        SmallText(text:'Dish',color: Colors.black38,),
                        Icon(Icons.arrow_drop_down_rounded),
                      ],
                    )
                  ],
                ),
                Center(
                  child: Container(
                    width:  Dimensions.height45,
                    height: Dimensions.height45,
                    child: Icon(Icons.search),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.height15),
                      color: Colors.green[200],
                       ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // call the FoodPageBody to be displayed and wrap with Expanded so its scrollable
        Expanded(
          child: SingleChildScrollView(
            child: FoodPageBody(),
            ),
          ),
        ],
      ),
    );
  }
}