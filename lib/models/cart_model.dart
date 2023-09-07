// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:food_oders/models/products_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  int? stars;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;
  
  CartModel({
    this.id,
    this.name,
    this.price,
    this.stars,
    this.img,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });

    //needed to convert json data from string  to object (encodable) 
  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductModel.fromJson(json['product']);
  }

  //create an EnCodable data by using the toJson so that you will be able to change from object to string list
    Map<String, dynamic> toJson(){
     return {
        "id":this.id,
        "name":this.name,
        "price":this.price,
        "stars":this.stars,
        "img":this.img,
        "quantity":this.quantity,
        "isExist":this.isExist,
        "time":this.time,
        "product":this.product!.toJson(),
     };
    }



}
