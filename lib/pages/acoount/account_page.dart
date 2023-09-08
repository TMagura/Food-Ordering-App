import 'package:flutter/material.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/account_widget.dart';
import 'package:food_oders/widgets/app_icon.dart';
import 'package:food_oders/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[200],
        title: Center(child: BigText(text: "Profile", size: Dimensions.fonts20,)),
      ),
      body: Container(
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
                   bigText: BigText(text: "Trymore@gmail.com", size: Dimensions.fonts20,),
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
                   
                    ],
                  ),
                ),
              ),
            ],
        ),
      ),
    );
  }
}