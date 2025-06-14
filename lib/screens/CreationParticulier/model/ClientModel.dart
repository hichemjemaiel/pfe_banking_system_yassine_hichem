import 'package:pfe_banking_system/screens/authentication/model/User.dart';

class ClientModel extends User{


  ClientModel({
    int? id,
    required String email,
    required String role,
  }): super( id: id , email : email , role : role);

  factory ClientModel.fromJson(Map<String , dynamic> json){
    return ClientModel(
      id: json["id"],
      email: json["email"],
      role: json["role"]
    );
  }

  Map<String , dynamic> toJson()=>{
    'id':id,
    'email':email,
    'role':role
  };
}