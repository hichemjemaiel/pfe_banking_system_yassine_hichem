import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/FamilleDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/SoinDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/TransportDTO.dart';

import '../../CreationEntreprise/network/DioClient.dart';
import '../../CreationParticulier/network/EndPoints.dart';

class TransportServiceDTO{
  Dio dio = DioClient().dio;

  Future<List<TransportDTO>> findAllTransport(int bankId)async{
    try{
      print("Fetching all transport");
      Response response = await dio.get("${EndPoints.findAllTransportForBankingAccount}/${bankId}");
      return (response.data as List).map((json) => TransportDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in fetching transports in Service ${e}");
      return [];
    }
  }
}