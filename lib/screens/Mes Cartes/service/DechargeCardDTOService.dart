import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/model/DechargeCardDTO.dart';

class DechargeCardDTOService{
  Dio dio = DioClient().dio;


    Future<List<DechargeCardDTO>> getAllDechargeCardDto(int id)async{
      try{
        print("Fettching all decharges : ");
        Response response = await dio.get("${EndPoints.findAllDechargeDTo}/${id}");
        return (response.data as List).map((json) => DechargeCardDTO.fromJson(json)).toList();
      }catch(e){
        print("Error in fetching Decharges in Service ${e}");
        return [];
      }
    }
}