// ignore_for_file: public_member_api_docs, sort_constructors_first

/// what we call a model is jus an object created from a class like below ,we are defining smthing nezvachinenge chiri so 
/// model represents how are we going to work with such an object  rimbori nei exactly 
/// and torishandisa sei rine chii interms of attributes or values
/// model rinotaura ne controller kuti tishandise zviri mu model toda kuziva kuti makamira sei 
/// hapana chinotaurika ne model kana pasina contoller 
/// repo will facilitates receive or send data chete  from server functionality 



class SignUpBody {
  String name;
  String phone;
  String email;
  String password;

  //a contructor for our model
  SignUpBody({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });

  //to post data to server it needs to be of type Map so convert object to map/json
 Map<String, dynamic> toJson(){
  final Map<String,dynamic> data = Map<String , dynamic>();
  data["f_name"] = this.name;
  data["phone"] = this.phone;
  data["email"] = this.email;
  data["password"]= this.password;
  return data;
 }
  


}
