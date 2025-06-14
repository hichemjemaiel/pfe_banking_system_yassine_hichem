import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/FamilleDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingDTO.dart';

import '../../CreationEntreprise/network/DioClient.dart';
import '../../CreationParticulier/network/EndPoints.dart';

class ShoppingServiceDTO{
  Dio dio = DioClient().dio;

  Future<List<ShoppingDTO>> findAllShopping(int bankId)async{
    try{
      print("Fetching all shopping");
      Response response = await dio.get("${EndPoints.findAllShoppingForBankingAccount}/${bankId}");
      return (response.data as List).map((json) => ShoppingDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in fetching shopping in Service ${e}");
      return [];
    }
  }
}