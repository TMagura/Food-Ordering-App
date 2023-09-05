// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_oders/controllers/popular_product_controller.dart';
import 'package:food_oders/controllers/recommended_product_controller.dart';
import 'package:food_oders/models/products_model.dart';
import 'package:food_oders/pages/food/popular_food_details.dart';
import 'package:food_oders/routes/route_helper.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/app_column.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:food_oders/widgets/icon_and_text_widget.dart';
import 'package:food_oders/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {

  final PageController pageController = PageController(viewportFraction: 0.87);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height =Dimensions.pageViewContainer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //attch a listenner for the changes in our page values so that we wil scale the pages
    pageController.addListener(() {
    setState(() {
      _currentPageValue = pageController.page!;
      // print(_currentPageValue.toString());
     });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      // slider section with products and to get the products use GetBuilder<PopularProductController>
      //the GetBuilder will provide updated data from the url and tell use 
      GetBuilder<PopularProductController>(builder: (popularProducts){
         return popularProducts.isLoaded
        ?  Container(
          color: Color.fromARGB(23, 56, 90, 39),
          height: Dimensions.pageView, 
            child: PageView.builder(
              controller: pageController,
              itemCount: popularProducts.popularProductList.length,
              itemBuilder: (context,position){
                //slider section
                return _buildPageItem(position,popularProducts.popularProductList[position]); //use extra param object of controller
              },),
         
        )
        : CircularProgressIndicator(color: Colors.amberAccent[900],
        );
      }),
        
      // dots indicator section
      GetBuilder<PopularProductController>(builder: (popularProducts){
     return DotsIndicator(
        dotsCount: popularProducts.popularProductList.length<1 ? 1 :popularProducts.popularProductList.length,
        position: _currentPageValue.ceil(),
        decorator: DotsDecorator(
          activeColor: Colors.purpleAccent,
        size: const Size.square(9.0),
        activeSize: const Size(18.0, 9.0),
        activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
         ),
        );
      }),
     SizedBox(height: Dimensions.height20,),
       //Recommended food text Section
       Container(
        margin: EdgeInsets.only(left: Dimensions.width30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            BigText(text:"Recommended"),
            SizedBox(width: Dimensions.width10,),
            Container(child: BigText(text: ".",color: Colors.black26,),),
            SizedBox(width: Dimensions.width10,),
            Container(
              child: SmallText(text: "Food List"),
            ),
          ],
        ),

       ),
       //list of food and images in a listView.Builder: Recommended food
       //GetBuilder is used to get the instace of a controller and be able to use its functions
       //so you wrap the part which will need the instance
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct){
          return recommendedProduct.isLoaded 
          ? Container( 
           child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),//this allow scrolling to involve the whole screen.
            shrinkWrap:true ,
            itemCount: recommendedProduct.recommendedProductList.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getRecommendedFood(index));
                },
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10,bottom: Dimensions.height20),
                  child: Row(
                    children: [
                      //row show images
                      Container(
                        width: Dimensions.listViewImgSize,
                        height: Dimensions.listViewImgSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: Colors.green[50],
                          image: DecorationImage(
                            fit:BoxFit.cover,
                            //now we get our images from our base URL fron the net 
                          image: NetworkImage (AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProduct.recommendedProductList[index].img!),
                            ),
                        ),
                      ),
                      //row show text
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextContSize,                 
                         decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight:Radius.circular( Dimensions.radius20),
                          bottomRight: Radius.circular(Dimensions.radius20)
                          ),
                         color: Colors.grey[200],
                         ),
                         child: Padding(
                          padding: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(text: recommendedProduct.recommendedProductList[index].name!),
                              SizedBox(height: Dimensions.height10,),
                              SmallText(text: "It has Zim characters",color: Colors.black45,),
                              SizedBox(height: Dimensions.height10,),
                              Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          IconAndTextWidget(icon: Icons.circle_sharp, text: "Best", iconColor: Colors.deepPurple),                       
                          IconAndTextWidget(icon: Icons.location_on, text: "1.8 km ", iconColor: Colors.lightGreen),
                          IconAndTextWidget(icon: Icons.access_time_rounded, text: "32 min", iconColor: Colors.redAccent),
                              ],
                            ),
                            ],
                          ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),),
          )
        : CircularProgressIndicator(color: Colors.blueAccent,);
        }),
      ],
    );
     
  }
}
 
 //this is the creation fuction which will be called in the return of the itemBuilder.

Widget _buildPageItem(int index, ProductModel popularProduct) {
  //we use Metrix 4 to come up with scalling
  Matrix4 matrix =Matrix4.identity();  //x y and z
  // var _currentPageValue=0.0;
  // double _scaleFactor = 0.8;
  // double _height =220;
  // if (index == _currentPageValue.floor()) {
  //   var currentScale = 1-(_currentPageValue - index)*(1-_scaleFactor);
  //   var currentTrans = _height*(1-currentScale)/2;
  //   matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
  // }else if(index == _currentPageValue.floor() +1){
  //   var currentScale = _scaleFactor+(_currentPageValue-index+1)*(1-_scaleFactor);
  //   var currentTrans = _height*(1-currentScale)/2;
  //   matrix = Matrix4.diagonal3Values(1, currentScale, 1);
  //   matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
  // }else if(index == _currentPageValue.floor()-1){
  //   var currentScale = 1-(_currentPageValue - index)*(1-_scaleFactor);
  //   var currentTrans = _height*(1-currentScale)/2;
  //   matrix = Matrix4.diagonal3Values(1, currentScale, 1);
  //   matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
  // }else{
  //   var currentScale = 0.8;
  //   matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 1);
  // }
  //Stack items to be on top of each other and they are children
  return Transform(
    transform: matrix,
    child: Stack(
      children: [
        //a clickable image to link to another page
        GestureDetector(
          onTap: () {
            // navigate to another page in GETX we use Get.to()
            Get.toNamed(RouteHelper.getPopularFood(index));
          },
          child: Container( 
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left:5,right:5),
            decoration: BoxDecoration( 
            borderRadius: BorderRadius.circular(Dimensions.radius30),
            color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
            image:DecorationImage(
            fit: BoxFit.cover,
            //now we get our images from our base URL fron the net 
            image: NetworkImage (AppConstants.BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!),
             ),
            ),
          ),
        ),
      
      Align(
        alignment: Alignment.bottomCenter,
         child:Container( 
          height: Dimensions.pageViewTextContainer,
          margin: EdgeInsets.only(left:Dimensions.height20,right:Dimensions.height20,bottom:Dimensions.height20),
          decoration: BoxDecoration( 
          borderRadius: BorderRadius.circular(Dimensions.radius30),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color:Color.fromARGB(143, 86, 255, 100),
              // blurRadius: 5.0,
              offset: Offset(0, 5),
            ),
          ],

  
          ),
          child: Container(
            padding: EdgeInsets.only(top:Dimensions.height15,left:Dimensions.height15,right:Dimensions.height15),
            child: AppColumn(text:popularProduct.name!),
          ),
        ),
         
         ),
      ],
    ),
  );
   
}