
  import 'package:flutter/material.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:get/get.dart';
  // show the snackbar weneva we hv an error on Authentication

void showCustomSnackBar(String message,{bool isError = true, String title = "Error"}){
 Get.snackbar(
  title, message,
  titleText: BigText(text: title,), 
  messageText: Text(message),
  snackPosition: SnackPosition.TOP,
  backgroundColor: Colors.orange,
  );
}