// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:food_oders/data/repository/recommended_product_repo.dart';
import 'package:food_oders/models/products_model.dart';
import 'package:get/get.dart';

import 'package:food_oders/data/repository/popular_product_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo}){}

   // results from our repo will be saved in this list but since its private we create a get again so that it will be public to our UI
  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get recommendedProductList => _recommendedProductList; 
  
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
   //check the status code for your response
   if (response.statusCode == 200) {// 200 means success
     log("now have data from recommended");
     _recommendedProductList = [];

     //before we add items since we get json type we need to convert it to usable data using models/create models
     _recommendedProductList.addAll(Product.fromJson(response.body).products);
    log('$_recommendedProductList');
    _isLoaded = true;
     //after we get the data we then setState but here we use update();
     update();
   }else{
    log("cant access data");
  
    _isLoaded= false;
   }

  }

}
