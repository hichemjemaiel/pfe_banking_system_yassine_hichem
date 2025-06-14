import 'package:pfe_banking_system/screens/authentication/model/LoginRequest.dart';

class RegisterRequest{
  String email;
  String password;

  RegisterRequest({required this.email, required this.password});

  factory RegisterRequest.fromJson(Map<String , dynamic> json){
    return RegisterRequest(
        email: json["email"],
        password: json["password"]);
  }
  Map<String , dynamic> toJson()=>{

        'email': email,
        'password': password
  };
}