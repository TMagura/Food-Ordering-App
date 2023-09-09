import 'package:flutter/material.dart';
import 'package:food_oders/controllers/cart_controller.dart';
import 'package:food_oders/controllers/popular_product_controller.dart';
import 'package:food_oders/controllers/recommended_product_controller.dart';
import 'package:food_oders/pages/auth/sign_in_page.dart';
import 'package:food_oders/pages/auth/sign_up_page.dart';
import 'package:food_oders/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:food_oders/helper/dependencies.dart' as MyDependencies; 

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //before you start loading anything first load the initialisations
   await MyDependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getcartData();
   // avoid our controller is splashScreen to be deleted we use the nesting of Controllers
   return GetBuilder<PopularProductController>(builder: (_){
    return GetBuilder<RecommendedProductController>(builder: (_){
          //if we use getX we wrap with the GetMaterialApp() always
      return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // home: SignInPage(),
            initialRoute: RouteHelper.getSplashScreen(),
            getPages: RouteHelper.routes,
        );
      });
   });

  }
}
