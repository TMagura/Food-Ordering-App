// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:food_oders/utils/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  final bool  isObscure;
  const AppTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  //text fields
          Container(
            margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(Dimensions.radius20),
              color: Colors.white, 
              boxShadow: [
                BoxShadow( 
                  blurRadius: 10, 
                  spreadRadius: 7, 
                  offset: Offset(1, 10), 
                  color: Colors.grey.withOpacity(0.2),
                )
              ],
            ),
          child: TextField(
             obscureText: isObscure ? true : false,
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: hintText, 
                prefixIcon: Icon(icon,color: Color.fromARGB(255, 136, 104, 7),), 
                //focused
                focusedBorder: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  borderSide: BorderSide(
                    width: 1.0, 
                    color: Colors.orange[900]!,
                  ),
                ),
                //enabled
                enabledBorder: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  borderSide: BorderSide(
                    width: 1.0, 
                    color: Colors.orange[900]!,
                  ),
                ),
                border:OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ), 
              ),
             ),
          );
  }
}
