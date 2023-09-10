// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:food_oders/data/api/api_client.dart';
import 'package:food_oders/utils/app_contants.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationRepo {
  final ApiClient apiClient; 
  final SharedPreferences sharedPreferences;
  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getAddressfromGeocode(LatLng latLng) async{
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
     '?lat=${latLng.latitude}&lng=${latLng.longitude}'
    );
  }

 String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS)!;
  }















}
