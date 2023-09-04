// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_oders/utils/dimensions.dart';

class AppIcon extends StatelessWidget {
  final IconData icon; //to be able to appone the icon type we declare here first as IconData;
  final Color backgroundColor; // using type of Color AS MY RETURN type  and specify inoshanda pai eg background
  final Color iconColor ;
  final double size;
  final double iconSize;
  
  AppIcon({
    Key? key,
    required this.icon,
     this.backgroundColor = const Color(0xFFfcf4e4),
     this.iconColor= const Color(0xFF756d54),
     this.size= 40,
     this.iconSize=16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: backgroundColor,
      ),
      //after we create a constructor with parameters we will need those to evaluate to the icon specifications
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
        
        ),
    );
  }
}
