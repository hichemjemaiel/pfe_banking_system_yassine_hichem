import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/FamilleDTO.dart';

import '../../CreationEntreprise/network/DioClient.dart';
import '../../CreationParticulier/network/EndPoints.dart';

class FamilleServiceDTO{
  Dio dio = DioClient().dio;

  Future<List<FamilleDTO>> findAllFamille(int bankId)async{
    try{
      print("Fetching all famille");
      Response response = await dio.get("${EndPoints.findAllFamilleForBankingAccount}/${bankId}");
      return (response.data as List).map((json) => FamilleDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in fetching famille in Service ${e}");
      return [];
    }
  }
}