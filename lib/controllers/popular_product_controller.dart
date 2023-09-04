// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:food_oders/models/products_model.dart';
import 'package:get/get.dart';

import 'package:food_oders/data/repository/popular_product_repo.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo}){}

   // results from our repo will be saved in this list but since its private we create a get again so that it will be public to our UI
  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList; 
  
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

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

}
