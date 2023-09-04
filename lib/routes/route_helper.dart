import 'package:food_oders/pages/food/popular_food_details.dart';
import 'package:food_oders/pages/food/recommended_food_detail.dart';
import 'package:food_oders/pages/home/main_food_page.dart';
import 'package:get/get.dart';

class RouteHelper{
  static const String initial  = "/";
  static const String popularFood ="/popular-food";
  static const String recommendedFood = "/recommended-food";

  //i can use a function so that later i can use parameters
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId)=>'$popularFood?pageId=$pageId';
  static String getRecommendedFood()=>'$recommendedFood';

//GetMaterialApp makes the use of the a list of pages called GetPage
 static List<GetPage> routes =[
  GetPage(name: initial, page: ()=>MainFoodPage(), transition: Transition.fadeIn,),
  GetPage(name: popularFood, page:(){
    //we shld pass the index which is our pageId so we get that variable by Get.parameter['pageId']
     var pageId = Get.parameters['pageId'];
   return PopularFoodDetail(pageId: int.parse(pageId!));}, transition: Transition.fadeIn,),
  GetPage(name: recommendedFood, page:()=>RecommendedFoodDetail(), transition: Transition.fadeIn,),
 ];

}