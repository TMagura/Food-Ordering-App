import 'package:get/get.dart';

class Dimensions{
  //whole screen sizes for padding and margin using GETX package:
  static double screenHeight = Get.context!.height;//its 844
  static double screenWidth = Get.context!.width;
  //calculate the diviser by saying screenheight/your needed height = 3.84
  static double pageViewContainer = screenHeight/3.84;
  static double pageViewTextContainer = screenHeight/7.03;
  static double pageView = screenHeight/2.64;
  //padding and margin 
  static double height10 = screenHeight/84.4;
  static double height15 = screenHeight/56.27;
  static double height20 = screenHeight/42.2;
  static double height45 = screenHeight/18.76;
  //padding and margin
  static double width10 = screenHeight/84.4;
  static double width15 = screenHeight/56.27;
  static double width20 = screenHeight/42.2;
  static double width30 = screenHeight/28.13;


  //fonts
  static double fonts20 = screenHeight/42.2;
  static double fonts26 = screenHeight/32.46;
  static double fonts16 = screenHeight/52.75;

  //icons
  static double iconSize24 = screenHeight/35.17;
  static double iconSize16 = screenHeight/52.75;

  // radius
  static double radius20 = screenHeight/42.2;
  static double radius30 = screenHeight/28.13;
  static double radius15 = screenHeight/56.27;

  //list view sizez
  static double listViewImgSize = screenWidth/3.25;
  static double listViewTextContSize = screenWidth/3.9;

  //For popular Food
  static double popularFoodImageSize = screenHeight/2.41;
  
  //Bottom Height Color
  static double bottomHeightBar = screenHeight/7.03;

  //splash screen
  static double splashImg = screenHeight/3.38;
}