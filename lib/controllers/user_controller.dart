
import 'package:food_oders/data/repository/user_repo.dart';
import 'package:food_oders/models/response_model.dart';
import 'package:food_oders/models/user_model.dart';
import 'package:get/get.dart';

///so in here the controller will use getX components so that it also facilitates statemanagement
///and to speak with the repository
///the controller always needs the repository to communicate 
class UserController extends GetxController implements GetxService {
//now do dependency injection : hapana apaa uku kungoti controller rinoda repo saka ripei repo yacho thats injecting
//so wen we call the instance of this Auth controller we feed the repo instance also
final UserRepo userRepo;

  UserController({
    required this.userRepo,
  });

 bool _isLoading = false;
 bool get isLoading => _isLoading;

 // the data that we get from the server is stored as an object of UserModel thus y we use models
 late UserModel _userModel;
 
UserModel get userModel=> _userModel;

  //function register from repo
  Future<ResponseModel> getUserInfo()async{
  
  Response response = await userRepo.getUserInfo();
  late ResponseModel responseModel;
  if (response.statusCode == 200) {
    _userModel = UserModel.fromJson(response.body);
    _isLoading = true;
    responseModel = ResponseModel(true, "success");
  }else{
    responseModel = ResponseModel(false, response.statusText!);
  }
  _isLoading=false;
  update();
  return responseModel;
  }
 }