import 'package:food_oders/pages/auth/sign_in_page.dart';
import 'package:food_oders/pages/cart/cart_page.dart';
import 'package:food_oders/pages/food/popular_food_details.dart';
import 'package:food_oders/pages/food/recommended_food_detail.dart';
import 'package:food_oders/pages/home/home_page.dart';
import 'package:food_oders/pages/home/main_food_page.dart';
import 'package:food_oders/pages/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper{
  //create names for our routes STEP 1
  static const String splashScreen = "/splash_page";
  static const String initial  = "/";
  static const String popularFood ="/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cartPage";
  static const String signIn = "/sign-in";

  //i can use a function so that later i can use parameters this is STEP 2
  static String getSplashScreen()=>'$splashScreen';
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId,String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageID, String page)=>'$recommendedFood?pageID=$pageID&page=$page';
  static String getCartPage()=>'$cartPage';
  static String getSignInPage()=>'$signIn';

//GetMaterialApp makes the use of the a list of pages called GetPage
//Create pages with the name relation so that it get picked in main page STEP 3
 static List<GetPage> routes =[
  GetPage(name: splashScreen, page: ()=>SplashScreen()),

  GetPage(name: initial, page: ()=>HomePage(), transition: Transition.fadeIn,),
  
  
  GetPage(name: popularFood, page:(){
    //we shld pass the index which is our pageId so we get that variable by Get.parameter['pageId']
     var pageId = Get.parameters['pageId'];
     var page = Get.parameters['page'];
   return PopularFoodDetail(pageId: int.parse(pageId!),page:page!);}, transition: Transition.fadeIn,),
  
  
  GetPage(name: recommendedFood, page:(){
   var pageID = Get.parameters['pageID'];
   var page = Get.parameters['page'];
   return RecommendedFoodDetail(pageID: int.parse(pageID!), page:page! );}, transition: Transition.fadeIn,),
   
   
   GetPage(name: cartPage, page: () {
     return CartPage();
   }, transition: Transition.fadeIn),

    GetPage(name: signIn, page: () {
     return SignInPage();
   }, transition: Transition.fadeIn)
 ];

}