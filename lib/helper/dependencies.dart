import 'package:food_oders/controllers/auth_controller.dart';
import 'package:food_oders/controllers/cart_controller.dart';
import 'package:food_oders/controllers/popular_product_controller.dart';
import 'package:food_oders/controllers/recommended_product_controller.dart';
import 'package:food_oders/data/api/api_client.dart';
import 'package:food_oders/data/repository/auth_repo.dart';
import 'package:food_oders/data/repository/cart_repo.dart';
import 'package:food_oders/data/repository/popular_product_repo.dart';
import 'package:food_oders/data/repository/recommended_product_repo.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

  //the STATE MANAGEMENT USING GETX it needs instances and their parameters to be returned in Get.LazyPut()
  //we are managing zvinhu zvino link ne Storage either local or server 
  //This is dependency injection zvatoda zvese in our system is thru this Get.LazyPut();
  //So after ta create  repo ne controller ne api client we make it available all over our system thru Get.lazyPut()
Future<void> init() async{
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
 //here initialise the GetX dependences first the ApiClient
 Get.lazyPut(()=>ApiClient(appBaseUrl:AppConstants.BASE_URL));

 //here initialise Repository using Get.find the instance will be find automatically
 Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
 Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
 Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
 Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  // here initialise Controllers 
 Get.lazyPut(() => CartController(cartRepo: Get.find())); 
 Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
 Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find(),));
 Get.lazyPut(() => AuthController(authRepo: Get.find()));
}