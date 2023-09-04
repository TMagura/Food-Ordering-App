import 'package:food_oders/data/api/api_client.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:get/get.dart';

//if we load data from the internet we expend the class with GetxService
class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;

  RecommendedProductRepo({required this.apiClient}); //our repo shld have an instance of the ApiClient always to facilitates the process
   
   //Responce is the result from the Servers linked from the apiClient our gateway
   Future<Response> getRecommendedProductList() async {
     return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
   }
}