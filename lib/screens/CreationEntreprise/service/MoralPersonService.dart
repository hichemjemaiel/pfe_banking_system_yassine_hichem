import 'dart:math';

import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/model/MoralPersonModel.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

class MoralPersonService{
  Dio dio = DioClient().dio;

  Future<bool> verifyEmailExistence(String email)async{
    try{
      Response response = await dio.post("${EndPoints.verifyMoralEmailExistence}/${email}");
      if(response.statusCode ==200 || response.statusMessage ==201){
        return true; // Email doesn't exist
      }
      return false ;
    } on DioException catch(e){
      if (e.response != null){
        String errorMessage = e.response?.data?.toString() ?? e.message ?? "Unknwon";
        if (errorMessage.contains("email") && errorMessage.contains("already exists")){
          return false;
        }
      }
      throw Exception("Erreur de connexion");
    }catch(e){
      throw Exception("Une erreur inattendue s'est produite");
    }
  }

  Future<bool> verifyPhoneExistence(String phone) async{
    try{
      Response response = await dio.post("${EndPoints.verifyMoralPhoneExistence}/${phone}");
      if(response.statusCode == 200 || response.statusCode ==201){
        return true; //Phone number doesn't exist
      }
      return false;
    }on DioException catch(e){
      if(e.response != null){
        String errorMessage = e.response?.data?.toString() ?? e.message ?? "Unknwon";
        if(errorMessage.contains("phone") && errorMessage.contains("already exists")){
          return false;
        }
      }
      throw Exception("Erreur de connexion");
    }catch(e){
      throw Exception("Une erreur inattendue s'est produite");
    }
  }
  Future<MoralPersonModel?> addMoralPerson(MoralPersonModel person)async{
    try{
        print("Passing moral person : ${person.toJson()}");
        Response response = await dio.post(EndPoints.addMoralPerson ,data:  person.toJson());
        if(response.data != null && response.data is Map<String , dynamic>){
          print("RAW API response : ${response.data}");
          return MoralPersonModel.fromJson(response.data);
        }else{
          print("Invalid Api data format ${response.data}");
          return null;
        }
    }catch(e){
      print("Error in Service ${e}");
      return null;
    }
  }
}