import 'package:food_oders/utils/app_contants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
 //this API client will be using GetX dependency
class ApiClient extends GetConnect implements GetxService{
 late String token;//all request need to have a token
 late String appBaseUrl;//url that talk to the server
//  late SharedPreferences sharedPreferences;
 late Map<String, String> _mainHeaders;
 ApiClient({required this.appBaseUrl /*required this.sharedPreferences*/}){
  baseUrl =appBaseUrl;
  timeout = Duration(seconds: 30);
  token =AppConstants.TOKEN;
  //headers are used to tell the server what type are you sending eg json type,Chaset and have unique Tokens
  _mainHeaders = {
    'Content-type':'application/json; charset= UTF-8',
    'Authorization':'Bearer $token'  //used for authentication with Bearer type 
  };
 } 

 //create a get Method for our data
  Future<Response> getData(String uri, {Map<String, String>? headers}) async{

   try {//always try coz intenet things are not certain
     Response response = await get(uri, 
     headers:headers??_mainHeaders 
     );// get is the keyword for Intenet stuff
     return response;
   } catch (e) {
     return Response(statusCode: 1, statusText: e.toString());
   }
  }

    //update the headers
  void updateHeader(String token){
    _mainHeaders = {
    'Content-type':'application/json; charset= UTF-8',
    'Authorization':'Bearer $token'  //used for authentication with Bearer type 
  };
  }

  //we are sending data /posting it to server
  //the uri is our end point .to speak ne server we want base url ne end point 
   Future<Response> postData(String uri,dynamic body) async {
    print(body.toString());
    try {
     Response response = await post(uri, body, headers: _mainHeaders);
     print(response.toString());
     return response;
    } catch (e) {
      print(e.toString());
     return Response(statusCode: 1,statusText: e.toString());
    }
   }
  



}