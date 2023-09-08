// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_oders/pages/auth/sign_up_page.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/app_text_field.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:food_oders/widgets/small_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var usernameController = TextEditingController();
    var phoneController = TextEditingController();
    

    return Scaffold(
      backgroundColor: Colors.white,
      //to avoid rendering of overflow use singlechildScrollView
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.01,),
            //circle avatar widget
            Container(
              height: Dimensions.screenHeight*0.30,
              child:Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage("assets/images/lion.png"),
                ),
              )
            ),
            //welcome text
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only( 
                left: Dimensions.width20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Text("Hello",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: Dimensions.fonts26*3,
                    fontFamily: "Roboto",
                  ),
                  ),       
                    RichText(text:TextSpan(
                      text: "Sign into your account",
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: Dimensions.fonts20,
                      )
                    ), 
                    ),
                  ],
              ),
            ),
            SizedBox(height: Dimensions.height20,),
            //text field for email 
            AppTextField(textEditingController: emailController,
             hintText: 'Enter email',
             icon: Icons.email,
             ), 
             SizedBox(height: Dimensions.height20,),
             //text field for password
          AppTextField(textEditingController: passwordController,
             hintText: 'Password',
             icon: Icons.password_sharp,
             ), 
         
             SizedBox(height: Dimensions.height15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              RichText(text:TextSpan(
                text: "Sign In to your account",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: Dimensions.fonts20,
                )
              ), 
             ),
             SizedBox(width: Dimensions.width20,),
              ],
            ),
             SizedBox(height: Dimensions.height20,),
             //Sign In  button
             Container(
              width: Dimensions.screenWidth/2,
              height: Dimensions.screenHeight/15,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 71, 133, 119),
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              child: Center(child: BigText(text: "Sign In", color: Colors.white,)),
             ),
              SizedBox(height: Dimensions.height45*1.5,),

              //a rich text is clickable
              RichText(text:TextSpan(
                text: "Don't have an Account?. ",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: Dimensions.fonts20,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=() => Get.to(()=>SignUpPage(), transition: Transition.fadeIn ),
                    text: "Create ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 9, 124, 255),
                      fontSize: Dimensions.fonts20,
                    ),
                    
                  ),
                ],
              ), 
             ),
             SizedBox(height: Dimensions.height15,),
          ],
        ),
      ),
    );
  }
}