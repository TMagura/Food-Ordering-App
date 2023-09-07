// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:food_oders/models/cart_model.dart';
import 'package:food_oders/models/products_model.dart';
import 'package:get/get.dart';

import 'package:food_oders/data/repository/cart_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({
    required this.cartRepo,
  });

   //create a Map which uses the CartModel to process data
  Map<int,CartModel> _items = {};
  Map<int,CartModel> get items => _items;
  //this list will save Sharedpreference data 
  List<CartModel> storageItems= [];

  //this function will be called in the popularproduct controller
  void  addItem(ProductModel product,int quantity){
    //even after removing we cant add a zero so use totalQuantity
    var totalQuantity = 0;
        //on Update we use containsKey a map function 
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value){
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id:value.id,
            name:value.name,
            price:value.price,
            stars:value.stars,
            img:value.img,
            quantity:value.quantity! + quantity,
            isExist:true,
            time:DateTime.now().toString(),
            product: product,
        );
      });

      //remove if the item if totalQuantity is zero
      if(totalQuantity <= 0){
       _items.remove(product.id!);
      }
    }else{
      if(quantity >0){
    //add items that are unique always and do not add if no quantity is selected
    _items.putIfAbsent(product.id!, () {
          log("added items to cart :id is"+product.id!.toString()+"quantity is  "+quantity.toString());
          return CartModel(
            id:product.id,
            name:product.name,
            price:product.price,
            stars:product.stars,
            img:product.img,
            quantity:quantity,
            isExist:true,
            time:DateTime.now().toString(),
            product: product,
          );
      });}else{
        Get.snackbar("There is an error", "You have to add something so you can save to Cart");
      }
      
    }
    cartRepo.addToCartList(getItems);
    update();

  }
  
  //check is IDs of productModel AND CartModel are the same so to retrieve data
      bool existInCart(ProductModel product){
        if(_items.containsKey(product.id)){
           return true;
        }else{
          return false;
        }
      }
  
  //calculate the the quantity which was previously added so that count wont always start at zero
  int getQuantity(ProductModel product){
    var quantity = 0;
     if(_items.containsKey(product.id!)){
        _items.forEach((key, value) {
          if(key == product.id!){
            quantity = value.quantity!;
          }
         });
     }
     return quantity;
   }
  
  //here add all items and display them in the Cart
  int get totalItem{
    var totalQuantity=0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  //a function that will create a list of items from the map using Enties method
   List<CartModel> get getItems{
    return _items.entries.map((e){
       return e.value;
    }).toList();
   }
  
  //a function to get total Amount of all in Cart
  int get totalAmount{
    var total =0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }
   
   //a function to getCartData from local storage
   List<CartModel> getcartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
   }
  
   // create a set method to initialise the storageList 
   set setCart(List<CartModel> items){
    storageItems = items;
    print("length is "+storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
   }
   // a function to save data in CART_HISTORY_LIST
   void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
   }
   //After we checkout we want to clear the data on the cart page
   void clear(){
    _items={};
    update();
   }
   
   //output the history information based on time of checkOut
   List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistorylist();   }


}
