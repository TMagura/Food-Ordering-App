// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:food_oders/data/api/api_client.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:get/get.dart';

class UserRepo {
  ApiClient apiClient;
  UserRepo({
    required this.apiClient,
  });

//get userInformation
 Future<Response> getUserInfo() async{
  return await apiClient.getData(AppConstants.USER_INFO_URI);
}
















}
