// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:food_oders/data/repository/location_repo.dart';
import 'package:food_oders/models/address_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({
    required this.locationRepo,
  });
   
   //vars for position using geolocator
   bool _isLoading = false;
  late Position _position;
  late Position _pickPosition;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  //getters
  bool get isLoading=> _isLoading;
  Position get position=> _position;
  Position get pickPosition=> _pickPosition;
   
   //vars for makers using geocoding
   Placemark _placemark = Placemark();
   Placemark _pickPlacemark = Placemark();

   //getters
   Placemark get placemark => _placemark;
   Placemark get pickPlacemark=>_pickPlacemark;

   //we create a list of addresses
   List<AddressModel> _addressList = [];
   List<AddressModel> get addressList => _addressList;

   late List<AddressModel> _allAddressList = [];
   List<String> _addressTypeList = ["home","office","others"];
   List<String> get addressTypeList => _addressTypeList;

   int _addressTypeIndex = 0;
   int get addressTypeIndex => _addressTypeIndex;

   void setAddressTypeIndex(int index){
    _addressTypeIndex = index;
    update();
   }

  
   //we will need to save our google map controller so we use this one
   late GoogleMapController _mapController;
   void setMapController(GoogleMapController mapController){
    _mapController = mapController;
   }

    //update camera if we pick new location
  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _isLoading = true;
      update();
      try {
        if(fromAddress){
          _position = Position(
            longitude: position.target.longitude, 
            latitude: position.target.latitude, 
            timestamp: DateTime.now(), 
            accuracy: 1, 
            altitude: 1, 
            heading: 1, 
            speed: 1, 
            speedAccuracy: 1
            );
        }else{
           _pickPosition = Position(
            longitude: position.target.longitude, 
            latitude: position.target.latitude, 
            timestamp: DateTime.now(), 
            accuracy: 1, 
            altitude: 1, 
            heading: 1, 
            speed: 1, 
            speedAccuracy: 1
            );
        }
        //here we tal with server to change the location
        if (_changeAddress) {
          String _address = await getAddressfromGeocode(
          LatLng(position.target.latitude, position.target.longitude)
          );
          fromAddress? _placemark=Placemark(name:_address):_pickPlacemark=Placemark(name:_address);
        }
      } catch (e) {
        print(e);
      }
    }
  }
   
  Future<String> getAddressfromGeocode(LatLng latLng) async{
    String _address = " No location yet";
    Response response = await locationRepo.getAddressfromGeocode(latLng);
    if(response.body["status"]=='OK'){
      log("i am talking to the server");
      _address = response.body["results"][0]['formatted_address'].toString();
      log("address in "+_address);
    }else{
      log("cant get google map services");
    }
    log("no such geo location");
    return _address;
   }

  late Map<String,dynamic> _getAddress;
  Map<String, dynamic> get getAddress => _getAddress;

    AddressModel getUserAddress(){
      late AddressModel _addressModel;
      _getAddress = jsonDecode(locationRepo.getUserAddress());
      try {
        _addressModel = AddressModel.fromJson(_getAddress);
      } catch (e) {
        print(e);
      }
      return _addressModel;
    }











}
