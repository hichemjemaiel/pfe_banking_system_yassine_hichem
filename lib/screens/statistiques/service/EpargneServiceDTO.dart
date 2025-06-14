import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneDTO.dart';

class EpargneServiceDTO{
  Dio dio = DioClient().dio;

  Future<List<EpargneDTO>> findAllEpargne(int bankId)async{
    try{
      print("Fetching all Epargne");
      Response response = await dio.get("${EndPoints.findAllEpargneForBankingAccount}/${bankId}");
      return (response.data as List).map((json) => EpargneDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in fetching epargne in Service ${e}");
      return [];
    }
  }
}