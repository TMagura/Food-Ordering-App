import 'package:flutter/material.dart';
import 'package:food_oders/base/custom_loader.dart';
import 'package:food_oders/controllers/auth_controller.dart';
import 'package:food_oders/controllers/cart_controller.dart';
import 'package:food_oders/controllers/user_controller.dart';
import 'package:food_oders/routes/route_helper.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/account_widget.dart';
import 'package:food_oders/widgets/app_icon.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(!_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      print("user is logged in");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: Center(child: BigText(text: "Profile", size: Dimensions.fonts20,)),
      ),
      body: GetBuilder<UserController>(builder: (userController){
        return !_userLoggedIn ?
          // userController.isLoading
      // ?
       Container(
        // height: , 
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimensions.height20),
        child: Column(
            children: [
              //big profile icon
               AppIcon(icon: Icons.person,
               backgroundColor: Colors.green[200]!,
               iconColor: Colors.white,
               iconSize: Dimensions.iconSize24*3.2,
               size: Dimensions.height15*11,
               ),
               SizedBox(height: Dimensions.height20,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                    //name Icon
                   AccountWidget(appIcon: AppIcon(icon: Icons.person,
                   backgroundColor:Colors.green[300]!,
                   iconColor: Colors.white,
                   iconSize: Dimensions.iconSize24,
                   size: Dimensions.height45,
                   ),
                   bigText: BigText(text: "Trymore", size: Dimensions.fonts20,),
                   ),
                   SizedBox(height: Dimensions.height20,),
                     //telephone icon
                   AccountWidget(appIcon: AppIcon(icon: Icons.phone,
                   backgroundColor:Colors.orange[300]!,
                   iconColor: Colors.white,
                   iconSize: Dimensions.iconSize24,
                   size: Dimensions.height45,
                   ),
                   bigText: BigText(text: "0783779699", size: Dimensions.fonts20,),
                   ),
                   SizedBox(height: Dimensions.height20,),
                   //email Icon
                   AccountWidget(appIcon: AppIcon(icon: Icons.email,
                   backgroundColor:Colors.blue[300]!,
                   iconColor: Colors.white,
                   iconSize: Dimensions.iconSize24,
                   size: Dimensions.height45,
                   ),
                   bigText: BigText(text: "email", size: Dimensions.fonts20,),
                   ),
                   SizedBox(height: Dimensions.height20,),
                   //address icon 
                   AccountWidget(appIcon: AppIcon(icon: Icons.location_on,
                   backgroundColor:Colors.red[300]!,
                   iconColor: Colors.white,
                   iconSize: Dimensions.iconSize24,
                   size: Dimensions.height45,
                   ),
                   bigText: BigText(text: "house Number", size: Dimensions.fonts20,),
                   ),
                   SizedBox(height: Dimensions.height20,),
                   //Detail icon
                   AccountWidget(appIcon: AppIcon(icon: Icons.message_outlined,
                   backgroundColor:Colors.purple[300]!,
                   iconColor: Colors.white,
                   iconSize: Dimensions.iconSize24,
                   size: Dimensions.height45,
                   ),
                   bigText: BigText(text: "Trymore messages ", size: Dimensions.fonts20,),
                   ),
                   SizedBox(height: Dimensions.height20,),
                    //logOut icon
                   GestureDetector(
                    onTap:() {
                      if(!Get.find<AuthController>().userLoggedIn()){
                      Get.find<AuthController>().clearSharedData();
                      Get.find<CartController>().clear();
                      Get.find<CartController>().clearCartHistory();
                      Get.toNamed(RouteHelper.getSignInPage());
                      } 
                    },
                     child: AccountWidget(appIcon: AppIcon(icon: Icons.logout,
                     backgroundColor:Color.fromARGB(255, 170, 70, 3)!,
                     iconColor: Colors.white,
                     iconSize: Dimensions.iconSize24,
                     size: Dimensions.height45,
                     ),
                     bigText: BigText(text: "logOut", size: Dimensions.fonts20,),
                     ),
                   ),
                   SizedBox(height: Dimensions.height20,),
                   
                    ],
                  ),
                ),
              ),
            ],
        ),
      
      // : CustomLoader()
        )
      : Container(child: Center(child: Text("you are not logged in"),),);

      })
    );
  }
}