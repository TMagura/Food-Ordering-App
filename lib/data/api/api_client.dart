import 'package:food_oders/utils/app_contants.dart';
import 'package:get/get.dart';
 //this API client will be using GetX dependency
class ApiClient extends GetConnect implements GetxService{
 late String token;//all request need to have a token
 late String appBaseUrl;//url that talk to the server
 late Map<String, String> _mainHeaders;
 ApiClient({required this.appBaseUrl}){
  baseUrl =appBaseUrl;
  timeout = Duration(seconds: 30);
  token =AppConstants.TOKEN;
  //headers are used to know the requests needed and their types eg json type,Chaset and have unique Tokens
  _mainHeaders = {
    'Content-type':'application/json; charset= UTF-8',
    'Authorization':'Bearer $token'  //used for authentication with Bearer type 
  };
 } 

 //create a get Method for our data
  Future<Response> getData(String uri) async{

   try {//always try coz intenet things are not certain
     Response response = await get(uri);// get is the keyword for Intenet stuff
     return response;
   } catch (e) {
     return Response(statusCode: 1, statusText: e.toString());
   }
  }

}