import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_oders/routes/route_helper.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  //use these 2 variables to do the animations and the power comes from the TickerProviderStateMixin
  late Animation<double> animation;
  late AnimationController controller;
  Future<void> _loadResources() async{
      //in our build  we need to load the data and get it ready
   await Get.find<PopularProductController>().getPopularProductList();
   await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadResources();
    controller = AnimationController(vsync: this,duration: Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    //after initialisation go to our initialPage
    Timer(Duration(seconds: 5), ()=> Get.offNamed(RouteHelper.getInitial()),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(child: Image.asset('assets/images/lion.png',width: Dimensions.splashImg,),),
            ),
           Center(child: Image.asset('assets/images/delicious.png',width: Dimensions.splashImg,)),
        ],
      ),
    );
  }
}