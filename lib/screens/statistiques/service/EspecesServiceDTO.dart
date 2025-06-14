import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesDTO.dart';

import '../../CreationEntreprise/network/DioClient.dart';
import '../../CreationParticulier/network/EndPoints.dart';

class EspecesServiceDTO{
  Dio dio = DioClient().dio;

  Future<List<EspecesDTO>> findAllEspeces(int bankId)async{
    try{
      print("Fetching all Especes");
      Response response = await dio.get("${EndPoints.findAllEspecesForBankingAccount}/${bankId}");
      return (response.data as List).map((json) => EspecesDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in fetching especes in Service ${e}");
      return [];
    }
  }
}