// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressModel {
late int? _id;
late String _addressType;
late String? _contactPersonName;
late String? _contactPersonNumber;
late String _address;
late String _latitude;
late String _longitude;

  // since our variables are made private we cant jus access them wen we call this model so we will then initialise them again
  AddressModel({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    address,
    latitude,
    longitude,
  }){
    //then in here we do initialisation of private fields
     
     _id = id;
     _addressType = addressType;
     _contactPersonName=contactPersonName;
     _contactPersonNumber= contactPersonNumber;
     _latitude= latitude;
     _longitude =longitude;


  }

  //create getters for these coz they are private fields in this model
     String get address => _address;
     String get addressType => _addressType;
     String? get contactPersonName=> _contactPersonName;
     String? get contactPersonNumber=> _contactPersonNumber;
     String get latitude => _latitude;
     String get longitude => _longitude;
     
  //create from json since we will get data from server
  AddressModel.fromJson(Map<String,dynamic> json){
    _id = json['id'];
    _addressType = json['address_type']??"";
    _contactPersonNumber = json['contact_person_number']??"";
    _contactPersonName = json['contact_person_name']??"";
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }





}
