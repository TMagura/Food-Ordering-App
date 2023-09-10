import 'package:flutter/material.dart';
import 'package:food_oders/controllers/auth_controller.dart';
import 'package:food_oders/controllers/location_controller.dart';
import 'package:food_oders/controllers/user_controller.dart';
import 'package:food_oders/utils/dimensions.dart';
import 'package:food_oders/widgets/app_icon.dart';
import 'package:food_oders/widgets/app_text_field.dart';
import 'package:food_oders/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}
class _AddAddressPageState extends State<AddAddressPage> {

   TextEditingController _addressController = TextEditingController();
   final TextEditingController _contactPersonName = TextEditingController();
   final TextEditingController _contactPersonNumber = TextEditingController();
   late bool _isLogged;

  //to have a screen to locate the position as you move we need camera position
  CameraPosition _cameraPosition = CameraPosition(target: LatLng(45.51563,-122.677432),zoom: 18);
  
  late LatLng _initialPosition = LatLng(45.51563,-122.677432);

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged&&Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isNotEmpty){
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"])
      ));

       _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"])
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text("Address Page",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.green[300],

      ),
      body: GetBuilder<UserController>(builder: (userController) {
        // if(userController.userModel!=null&& _contactPersonName.text.isEmpty){
          _contactPersonName.text = /*'${userController.userModel?.name??*/'Trymore';
          _contactPersonNumber.text = /*'${userController.userModel?.phone??*/'0783779699';
          // if(Get.find<LocationController>().addressList.isNotEmpty){
          //  _addressController.text = Get.find<LocationController>().getUserAddress().address;
          // }

        // }
        return GetBuilder<LocationController>(builder: (locationController) {
        _addressController.text = '${locationController.placemark.name??"trymore"}'
        '${locationController.placemark.locality??"gtwn"}'
        '${locationController.placemark.postalCode??"10718"}'
        '${locationController.placemark.country??"zim"}';
        print(_addressController.text);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //show map container
           Container(
            height: Dimensions.height20*7,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(Dimensions.radius15/2),
              border: Border.all(
                width: 2,color: Theme.of(context).primaryColor,
              ),
            ),
           child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(target:_initialPosition,zoom: 18),
                zoomControlsEnabled: false,
                compassEnabled: false, 
                indoorViewEnabled: true, 
                mapToolbarEnabled: false,
                //this talks to the server 
                onCameraIdle: () {
                  locationController.updatePosition(_cameraPosition,true);
                },
                onCameraMove: ((position)=> _cameraPosition=position),
                //this is for one time setup
                onMapCreated: (GoogleMapController controller) {
                  locationController.setMapController(controller);
                },
                ),
            ],
           ),
        
           ),
           //show details
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(height: Dimensions.height20*3.2,
                child: ListView.builder( 
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: locationController.addressTypeList.length,
                  itemBuilder: (context, index){
                    return InkWell(
                      onTap: () {
                        locationController.setAddressTypeIndex(index);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
                        margin: EdgeInsets.only(right: Dimensions.width20),
                      decoration: BoxDecoration( 
                        borderRadius: BorderRadius.circular(Dimensions.radius15/2), 
                        color: Colors.grey[50],
                        boxShadow:[
                          BoxShadow(
                            color: Colors.green[100]!,
                            spreadRadius: 1, 
                            blurRadius: 5, 
                
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            index == 0 ? Icons.home :index==1 ? Icons.work : Icons.location_on,
                            color: locationController.addressTypeIndex == index? Colors.red:Theme.of(context).disabledColor
                          )
                        ],
                      ),
                      ),
                    );
                  }),
                ),
              ),
            ),
           
        
            SizedBox(height: Dimensions.height20,),  
            Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: BigText(text: "Delivery address"),
            ),
            // SizedBox(height: Dimensions.height20,),
            AppTextField(textEditingController: _addressController, hintText: 'Your address', icon: Icons.map_outlined),
            SizedBox(height: Dimensions.height20,),
                      Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: BigText(text: "Contact Name"),
            ),
            AppTextField(textEditingController: _contactPersonName, hintText: 'Your Name', icon: Icons.person),
            SizedBox(height: Dimensions.height20,),
                      Padding(
              padding: const EdgeInsets.only(left:20.0),
              child: BigText(text: "Your Number"),
            ),
            AppTextField(textEditingController: _contactPersonNumber, hintText: 'Your Phone', icon: Icons.phone),
            
          ],
              ),
        );
      },);
      },),
      bottomNavigationBar: GetBuilder<LocationController>(builder: (locationController) {
        return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           //add to cart section
         Container(
        height: Dimensions.bottomHeightBar,
        padding: EdgeInsets.only(
          top: Dimensions.height20,
          bottom: Dimensions.height20,
          left: Dimensions.width20,
          right: Dimensions.width20,
          ),
          decoration: BoxDecoration( 
            color: Colors.green[50],
            borderRadius: BorderRadius.only( 
              topLeft: Radius.circular(Dimensions.radius20),
              topRight: Radius.circular(Dimensions.radius20),
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                
                onTap: () {
                  
                },
                child:Container(
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  right: Dimensions.width20/2,
                  left: Dimensions.width20/2,
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 5, 94, 8),
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                ) ,
                child: BigText(text: "Save Address",color: Colors.white,size: 24,),
              ),
              ),
            ],
          ),
      ),
        ],
      );
      },)   
   
    );
  }
}