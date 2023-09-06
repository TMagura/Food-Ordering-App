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
}
