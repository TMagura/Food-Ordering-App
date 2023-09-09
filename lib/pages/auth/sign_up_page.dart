// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_oders/base/custom_loader.dart';
import 'package:food_oders/base/show_custom_message.dart';
import 'package:food_oders/controllers/auth_controller.dart';
import 'package:food_oders/models/signup_body_model.dart';
import 'package:food_oders/routes/route_helper.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/app_text_field.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:food_oders/widgets/small_text.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var usernameController = TextEditingController();
    var phoneController = TextEditingController();
    
    //list of images to show on thw wrap widget data takes list of identical stuff
    var signUpImages = [
      "fb.jpg",
      "twitter.jpg",
      "google.png",
      
    ];
    
      //create a method for validation
   void _registration(AuthController authController){
    String name = usernameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(name.isEmpty){
     showCustomSnackBar("Name can't be Empty", title: "Name Error");
    }else if(phone.isEmpty){
      showCustomSnackBar("Phone can't be Empty", title: "Phone Error");
    }else if(email.isEmpty){
      showCustomSnackBar("email can't be Empty", title: "Email Error");
    }else if(!GetUtils.isEmail(email)){
     showCustomSnackBar("Email is Invalid", title: "Email  Error");
    }else if(password.isEmpty){
     showCustomSnackBar("Password can't be Empty", title: "Password Error");
    }else if(password.length<6){
     showCustomSnackBar("Password is too short it must be more than 6 character", title: "Password Error");
    }else{
     
     SignUpBody signUpBody = SignUpBody(name: name, phone: phone, email: email, password: password);
    authController.registration(signUpBody).then((status) {
      if(status.isSuccess){
        showCustomSnackBar("Registered Successfully", title: "SignUp Message");
        Get.toNamed(RouteHelper.getInitial());
      }else{
        showCustomSnackBar(status.message, title: "SignUp Message");
        Get.toNamed(RouteHelper.getInitial());
      }
    },);

    }

   }


    return Scaffold(
      backgroundColor: Colors.white,
      //to avoid rendering of overflow use singlechildScrollView
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading 
       ?   SingleChildScrollView(
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
            //text field for email 
            AppTextField(textEditingController: emailController,
             hintText: 'Enter email',
             icon: Icons.email,
             ), 
             SizedBox(height: Dimensions.height20,),
             //text field for password
          AppTextField(textEditingController: passwordController,
             hintText: 'Password',
             isObscure: true,
             icon: Icons.password_sharp,
             ), 
              SizedBox(height: Dimensions.height20,),
             //text field for username
          AppTextField(textEditingController: usernameController,
             hintText: 'Username',
             icon: Icons.person,
             ),
              SizedBox(height: Dimensions.height20,),
             //text field for phone
          AppTextField(textEditingController: phoneController,
             hintText: 'Phone',
             icon: Icons.phone,
             ),
             SizedBox(height: Dimensions.height15,),
             //signup  buttons
             GestureDetector( 
              onTap: () {
                _registration(_authController);
              },
               child: Container(
                width: Dimensions.screenWidth/2,
                height: Dimensions.screenHeight/15,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 71, 133, 119),
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ),
                child: Center(child: BigText(text: "Sign Up", color: Colors.white,)),
               ),
             ),
              SizedBox(height: Dimensions.height15,),
              //a rich text is clickable
              RichText(text:TextSpan(
                recognizer: TapGestureRecognizer()..onTap=() => Get.back(),
                text: "Already have an Account?.",
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: Dimensions.fonts20,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=() => Get.back(),
                    text: " Sign In",
                    style: TextStyle(
                      color: Color.fromARGB(255, 3, 111, 235),
                      fontSize: Dimensions.fonts20,
                    )
                  ),
                ],
              ), 
             ),
             SizedBox(height: Dimensions.height15,),
             //signUp methods
             RichText(text:TextSpan(
                text: "Sign Up using the following",
                style: TextStyle(
                  color: Color.fromARGB(255, 172, 17, 17),
                  fontSize: Dimensions.fonts20,
                )
              ), 
             ),
             Wrap(
              children: List.generate(3, (index) => CircleAvatar(
                radius: Dimensions.radius30,
                backgroundImage: AssetImage("assets/images/"+signUpImages[index]),
              )),
             )
          ],
        ),
      )
      : CustomLoader();
       
     
      })
    );
      

  }
}