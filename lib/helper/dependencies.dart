import 'package:food_oders/controllers/cart_controller.dart';
import 'package:food_oders/controllers/popular_product_controller.dart';
import 'package:food_oders/controllers/recommended_product_controller.dart';
import 'package:food_oders/data/api/api_client.dart';
import 'package:food_oders/data/repository/cart_repo.dart';
import 'package:food_oders/data/repository/popular_product_repo.dart';
import 'package:food_oders/data/repository/recommended_product_repo.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

  //the STATE MANAGEMENT USING GETX it needs instances and their parameters to be returned in Get.LazyPut()
  //we are managing zvinhu zvino link ne Storage either local or server 
Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
 //here initialise the GetX dependences first the ApiClient
 Get.lazyPut(()=>ApiClient(appBaseUrl:AppConstants.BASE_URL));

 //here initialise Repository using Get.find the instance will be find automatically
 Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
 Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
 Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
  // here initialise Controllers 
 Get.lazyPut(() => CartController(cartRepo: Get.find())); 
 Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
 Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find(),));
}