// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:food_oders/models/signup_body_model.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:food_oders/data/api/api_client.dart';

/// here manje since repo works with server/api and local storage
///  it needs to have api client ne sharedpref instances kuti ishande

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

//repo needs api client and model to send  data only not paku receiver
 Future<Response> registration(SignUpBody signUpBody) async {
  return await apiClient.postData(AppConstants.REGISTRATION_URI, signUpBody.toJson());
}

//save the user token tells user is authenticated
//token works like this if i register well i get token and save it in my phone locally
//then next time if i open the app it checks on my token to see if im authenticated
saveUserToken(String token) async {
 apiClient.token = token;
 apiClient.updateHeader(token);
 return await sharedPreferences.setString(AppConstants.TOKEN, token);
}




}
