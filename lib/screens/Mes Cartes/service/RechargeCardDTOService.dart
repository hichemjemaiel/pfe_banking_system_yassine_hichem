import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/model/RechargeCardDTO.dart';

class RechargeCardDTOService{
  Dio dio = DioClient().dio;

  Future<List<RechargeCardDTO>> getAllRechargeCardDto(int id) async{
    try{
      print("Fetching all recharge cards history");
       Response response  = await dio.get("${EndPoints.getAllRechargesForCard}/${id}");
       return (response.data as List).map((json) => RechargeCardDTO.fromJson(json)).toList();
    } catch(e){
      print("Error in fetching recharge cards ${e}");
      return [];
    }
  }
}