import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/FamilleDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/SoinDTO.dart';

import '../../CreationEntreprise/network/DioClient.dart';
import '../../CreationParticulier/network/EndPoints.dart';

class SoinServiceDTO{
  Dio dio = DioClient().dio;

  Future<List<SoinDTO>> findAllSoin(int bankId)async{
    try{
      print("Fetching all soin");
      Response response = await dio.get("${EndPoints.findAllSoinForBankingAccount}/${bankId}");
      return (response.data as List).map((json) => SoinDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in fetching soin in Service ${e}");
      return [];
    }
  }
}