// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:food_oders/models/response_model.dart';
import 'package:food_oders/models/signup_body_model.dart';
import 'package:get/get.dart';

import 'package:food_oders/data/repository/auth_repo.dart';

///so in here the controller will use getX components so that it also facilitates statemanagement
///and to speak with the repository
///the controller always needs the repository to communicate 
class AuthController extends GetxController implements GetxService {
//now do dependency injection : hapana apaa uku kungoti controller rinoda repo saka ripei repo yacho thats injecting
//so wen we call the instance of this Auth controller we feed the repo instance also
final AuthRepo authRepo;

  AuthController({
    required this.authRepo,
  });

 bool _isLoading = false;
 bool get isLoading => _isLoading;

  //function register from repo
  Future<ResponseModel> registration(SignUpBody signUpBody)async{
  _isLoading = true;
  update();
  Response response = await authRepo.registration(signUpBody);
  late ResponseModel responseModel;
  if (response.statusCode == 200) {
    authRepo.saveUserToken(response.body["token"]);//we get the token in the response body
    responseModel = ResponseModel(true, response.body["token"]);
  }else{
    responseModel = ResponseModel(false, response.statusText!);
  }
  _isLoading=false;
  update();
  return responseModel;
 }


 //function login from repo and we also need to save the token because if maybe you logged out before
  Future<ResponseModel> login(String email,String password)async{
    print("getting token ");
    print(authRepo.getUserToken().toString());
  _isLoading = true;
  update();
  Response response = await authRepo.login(email,password);
  late ResponseModel responseModel;
  if (response.statusCode == 200) {
    print("we have token from backend");
    authRepo.saveUserToken(response.body["token"]);//we get the token in the response body
    responseModel = ResponseModel(true, response.body["token"]);
  }else{
    responseModel = ResponseModel(false, response.statusText!);
  }
  _isLoading=false;
  update();
  return responseModel;
 }


//Save the user email and password to shared pref this function is from repo
 void saveUserNumberAndPassword ( String number , String password){
  authRepo.saveUserNumberAndPassword(number, password);
}

  //user token to check if user is logged in for checkout from repo
 bool userLoggedIn(){
  return authRepo.userLoggedIn();
  }


/// clearing data for logOut
 bool clearSharedData(){
  return authRepo.clearSharedData();
 }







}
