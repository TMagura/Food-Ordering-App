// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:food_oders/widgets/icon_and_text_widget.dart';
import 'package:food_oders/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(text: text,size:Dimensions.fonts26), //will check this if in home screen we get overflows
                SizedBox(height: Dimensions.height10,),
                Row(
                 children: [
                  // a wrap create identical items so its used for our Stars
                  Wrap(
                    children: List.generate(5, (index) => Icon(Icons.star,color: Colors.green[400],),),
                  ),
                  SizedBox(width: 5,),
                  SmallText(text: "4.5"),
                  SizedBox(width: 10,),
                  SmallText(text: "1273"),
                  SizedBox(width: 2,),
                  SmallText(text: "Comments"),
                 ],
                ),
                SizedBox(height: Dimensions.height10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconAndTextWidget(icon: Icons.circle_sharp, text: "Best", iconColor: Colors.deepPurple),
                    SizedBox(width: 20,),
                    IconAndTextWidget(icon: Icons.location_on, text: "1.8 km ", iconColor: Colors.lightGreen),
                    SizedBox(width: 20,),
                    IconAndTextWidget(icon: Icons.access_time_rounded, text: "32 min", iconColor: Colors.redAccent),
                  ],
                ),
              ],
            );
    
  }
}
