import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Depot/model/OperateurModel.dart';

class OperateurService{
  Dio dio = DioClient().dio;

  Future<List<OperateurModel>> getAllOperateurs()async{
    try{
      print("Fetching all operateurs");
      Response response = await dio.get("${EndPoints.getAllOperateurs}");
      return (response.data as List).map((json) => OperateurModel.fromJson(json)).toList();
    }catch(e){
      print("Error in OperateurService ${e}");
      return [];
    }
  }
  
  Future<OperateurModel?> getOperateurModel(int? operateurId)async{
    try{
      print("Fetching operateur model");
      Response response = await dio.get("${EndPoints.getAllOperateurs}/${operateurId}");
      return OperateurModel.fromJson(response.data);
    }catch(e){
      print("Error in service operateur model");
    }
  }
}