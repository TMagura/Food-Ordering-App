// ignore_for_file: public_member_api_docs, sort_constructors_first, use_function_type_syntax_for_parameters
var netMap  = {
  "name":"trymore",
  "surname":"magura",           //json 1
  "age":"27",
  "sex":"male",

  //another inserted map as a List so we have nested Map/json
   "phoneNum":[
   {
    "sp":"econet",
    "numb":"0783779699"         //json 2
   },
   {
    "sp":"netone",               //json 3
    "numb":"0718410143"
   }
   ],
};

//cretate an object of the class person using json
 var obj = Person.fromJson(netMap);

 var phoneNumbers = obj.phoneNum; // so that i can accsess all phoneNumbers
  //  phoneNumber!.map((e){    
  //    print(e.sp);              // now to acces the phoneNum yu can using a .map((){})
  //  });
  

// so since we have 3 jsons we need to create Models for these 
class Person {
String? name;               //create this model 1
String? surname;
int? age;
String? sex;
List<PhoneNum>? phoneNum;     //it takes the list of other maps

  Person({
    this.name,
    this.surname,
    this.age,               //create its constructor
    this.sex,
    this.phoneNum,
  });

  //create anothe named Contructor that is using the Argument of Map/json
   
   Person.fromJson(Map<String,dynamic> json){
     name = json['name'];
     surname = json['surname'];
     age = json['age'];
     sex = json['sex'];
  //now for phoneNum we must first check if its not null then we loop out
    if(json['phoneNum'] != null){
      phoneNum = <PhoneNum> [];  // empty the list before you start adding
      (json['phoneNum'] as List).forEach((element) {  //loop thru that json map element of phoneNum
        phoneNum!.add(PhoneNum.fromJson(element)); //add  the Instances  to the list
      });
     }

   }
}




//create the model again for the inner section
class PhoneNum {
 String? sp;               //this will facilitates for json 2 and jason 3 because they are the same in nature
 String? numb;

  PhoneNum({
    this.sp,        //create its constructor
    this.numb,
  });

  //create another constructor but this one has the map Arguments it takes in the map

  PhoneNum.fromJson(Map<String,dynamic> json) {
     sp = json['sp'];
     numb = json['numb'];
  }

}
