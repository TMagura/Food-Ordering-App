import 'package:flutter/material.dart';
import 'package:food_oders/base/no_data_page.dart';
import 'package:food_oders/controllers/auth_controller.dart';
import 'package:food_oders/controllers/cart_controller.dart';
import 'package:food_oders/controllers/popular_product_controller.dart';
import 'package:food_oders/controllers/recommended_product_controller.dart';
import 'package:food_oders/pages/auth/sign_in_page.dart';
import 'package:food_oders/routes/route_helper.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/app_icon.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:food_oders/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //top icons at appbar
          Positioned(
            top: Dimensions.height20*3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //back icon
              AppIcon(
                icon: Icons.arrow_back,
                iconColor: Colors.white,
                backgroundColor: Colors.red,
                size: Dimensions.iconSize24*1.5,      
              ),
              SizedBox(width: Dimensions.width30*4,),
              //home icon
              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getInitial());
                },
                child: AppIcon(
                  icon: Icons.home_outlined,
                  iconColor: Colors.white,
                  backgroundColor: Colors.red,
                  size: Dimensions.iconSize24*1.5,      
                ),
              ),
              //cart icon
              AppIcon(
                icon: Icons.shopping_cart,
                iconColor: Colors.white,
                backgroundColor: Colors.red,
                size: Dimensions.iconSize24*1.5,      
              ),
            ],
          ),
          ),
          //listview of items
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0
            ?  Positioned(
            top: Dimensions.height20*5,
            left: Dimensions.width20,
            right: Dimensions.width20,
            bottom: 0,
            child: Container(
              color: Colors.white,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: GetBuilder<CartController>(builder: (cartController){
                  var _cartList = cartController.getItems; 
                  return  ListView.builder(
                    itemCount: _cartList.length,
                    itemBuilder: (_,index){
                     return Container(
                
                      height: 100,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(bottom: 10,top: Dimensions.height15),
                      child: Row(
                        children: [
                          //image container
                          GestureDetector(
                            onTap: () {
                              //check where this product comes from either recommended ot popular and navigate to it
                              var popularIndex = Get.find<PopularProductController>()
                              .popularProductList
                              .indexOf(_cartList[index].product!);
                              if(popularIndex>=0){
                                Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cartpage" ));
                              }else{
                               var recommendedIndex = Get.find<RecommendedProductController>()
                              .recommendedProductList
                              .indexOf(_cartList[index].product!);
                              if(recommendedIndex<0){
                               Get.snackbar("History Error",
                               "cant access history products",
                               backgroundColor: Colors.orangeAccent,
                               colorText:Colors.white);
                              }else{
                                //we pass parameters to be used wen we get to the page
                                Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartpage" )); 
                              }

                               
                              }

                            },
                            child: Container(
                              width: Dimensions.height20*5,
                              height: Dimensions.height20*5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!),
                                  fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                           SizedBox(width: Dimensions.width10,),
                           //text column
                           Expanded(child: Container(
                            height: Dimensions.height20*5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BigText(text: cartController.getItems[index].name!),
                                SmallText(text: "spicy hot",),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    BigText(text: "\$${cartController.getItems[index].price!}", color: Colors.redAccent,),
                            
                                // plus and minus icons
                                Container(
                                  padding: EdgeInsets.only(
                                    top: Dimensions.height10,
                                    bottom: Dimensions.height10,
                                    right: Dimensions.width10,
                                    left: Dimensions.width10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                                  ) ,
                                  // this is the left counter
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // substract button
                                        cartController.addItem(_cartList[index].product!, -1);
                                      },
                                      child: Icon(Icons.remove, color: Colors.black26,),
                                      ),
                                    SizedBox(width: (Dimensions.width10),),
                                    BigText(text:_cartList[index].quantity!.toString()),
                                    SizedBox(width: (Dimensions.width10),),
                                    GestureDetector(
                                      onTap: (){
                                        // add button
                                        cartController.addItem(_cartList[index].product!, 1);
                                      },
                                      child: Icon(Icons.add, color: Colors.black26,),
                                      ),
                                      ],
                                    ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                           ),),
                        ],
                      ),
                     );
                  });
                  }
                ),
              ),
            ),
           )
            : NoDataPage(text: "The cart is empty Please add something");
          }),
        ],
      ),
    //bootomNavigator
       bottomNavigationBar:GetBuilder<CartController>(builder: (cartProduct) {
        return  Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
          top: Dimensions.height20,
          bottom: Dimensions.height20,
          left: Dimensions.width20,
          right: Dimensions.width20,
          ),
          decoration: BoxDecoration( 
            color: Colors.red[50],
            borderRadius: BorderRadius.only( 
              topLeft: Radius.circular(Dimensions.radius20),
              topRight: Radius.circular(Dimensions.radius20),
            ),
          ),
          child: cartProduct.getItems.length > 0
        ?  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  right: Dimensions.width10,
                  left: Dimensions.width10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ) ,
                // this is the left counter
               child: Row(
                children: [
                  SizedBox(width: (Dimensions.width10),),
                  BigText(text: "\$ ${cartProduct.totalAmount.toString()}"),
                  SizedBox(width: (Dimensions.width10),),
                ],
               ),
              ),
              //botomNavigationBar for Cart
            GestureDetector(
              onTap: () {
                //before we checkOut check user if is Logged in we make use of the token check
                //here we hv no database so bypass
               if(!Get.find<AuthController>().userLoggedIn()){
                cartProduct.addToHistory();
               }else{
                Get.toNamed(RouteHelper.getSignInPage());
               }
              
              },
             child: Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  right: Dimensions.width20/4,
                  left: Dimensions.width20/4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green[200],
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ) ,
                
                  child: BigText(text: "Check Out",color: Colors.black87,),
                  
              ),
              ),
            ],
          )
        : Container()

      );
      },)


    
    );
  }
}