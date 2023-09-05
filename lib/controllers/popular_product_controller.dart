// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:food_oders/controllers/cart_controller.dart';
import 'package:food_oders/models/cart_model.dart';
import 'package:food_oders/models/products_model.dart';
import 'package:get/get.dart';

import 'package:food_oders/data/repository/popular_product_repo.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo}){}

   // results from our repo will be saved in this list but since its private we create a get again so that it will be public to our UI
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList; 
  late CartController _cart;
  
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  
  //this function will get the data from the URL
  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularproductList();
   //check the status code for your response
   if (response.statusCode == 200) {// 200 means success
     print("now have data");
     _popularProductList = [];

     //before we add items since we get json type we need to convert it to usable data using models/create models
     _popularProductList.addAll(Product.fromJson(response.body).products);
    print(_popularProductList);
    _isLoaded = true;
     //after we get the data we then setState but here we use update();
     update();
   }else{
    print("cant access data");
    _isLoaded= false;
   }

  }
   
   //this function responsible to increase or decrease amount 
   void setQuantity(bool isIncrement){
    if (isIncrement == true) {
      log('$quantity');
      _quantity = checkQuantity(_quantity + 1);
      log("quantity ="+_quantity.toString());
    }else{
      _quantity = checkQuantity(_quantity - 1);
    }
    //this is our set state
    update();
   }
 
    //this funtion checks to see if number does not go below 0
    int checkQuantity(int quantity){
      if((_inCartItems+ quantity)<0){
        Get.snackbar("Item Error","you can not have less than Zero items");
        //to avoid fallback of the values we clear the cache
        if(_inCartItems >0){
          _quantity = -_inCartItems;
          return _quantity;
        }
       return 0;
      }else if((_inCartItems+ quantity) >10){
        Get.snackbar("Item Error","you can not have more than Ten items"); 
      return 10;
      }else{
        return quantity;
      }
    }
   
   // this will set the initial quantity to zero to avoid data passed to diff pages
   void initQuantity(ProductModel product, CartController cart){
    _quantity = 0;
    _inCartItems=0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);
    //if itemExist
    log("exist here"+exist.toString());
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
     log("quantity is "+_inCartItems.toString());
   }

   //call the add item from the cart_Controller inside another function
   void addItem(ProductModel product){
    // if(_quantity >0){
     _cart.addItem(product, _quantity);
     _quantity = 0;
     _inCartItems = _cart.getQuantity(product);
     _cart.items.forEach((key, value) {
      log("the id is"+value.id.toString()+"quantity is"+value.quantity.toString());
      });
    // }else{
      // Get.snackbar("There is an error", "You have to add something so you can save to Cart");
    // }
    update();
   }
   
   //call the cart totalItems here
   int get totalItems{
    return _cart.totalItem;
   }
   
    //create a list from the given Map
    List<CartModel> get getItems{
      return _cart.getItems;
    }

}
