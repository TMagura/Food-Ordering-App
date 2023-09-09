import 'package:flutter/material.dart';
import 'package:food_oders/controllers/auth_controller.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    print(" loading ${Get.find<AuthController>().isLoading}");
    return Center(
      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.height20*5,
        decoration: BoxDecoration( 
          color: Colors.green[50], 
          borderRadius: BorderRadius.circular(Dimensions.radius20)
           ),
           alignment: Alignment.center, 
           child: CircularProgressIndicator(),
      ),
    );
  }
}