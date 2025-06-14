import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/model/DechargeCardModel.dart';

class DechargeCardService{
  Dio dio = DioClient().dio;


  Future<DechargeCardModel?> addDecharge(DechargeCardModel dechargeCard, int CId)async{
    try{
      print("Adding Decharge card ${dechargeCard.toJson()}");
      Response response = await dio.post("${EndPoints.addDechargeCard}/${CId}",data: dechargeCard.toJson());
      if(response.data != null && response.data is Map<String , dynamic> ){
        print("Raw Api Response ${response.data}");
        return DechargeCardModel.fromJson(response.data);
      }else{
        print("Invalid Api Response ${response.data}");
      }
    }catch(e){
      print("Error in adding Decharge Card in Service ${e}");
    }
  }

  Future<bool> addDechargeCardToCard(int DId , int CId)async{
    try{
      print("Adding Decharge ${DId} to card ${CId}");
      Response response = await dio.post("${EndPoints.addDechargeCardToCard}/${DId}/${CId}");
      if(response.statusCode == 200 || response.statusCode ==201){
        print("Decharge ${DId} add successfully to card ${CId}");
        return true;
      }else{
        print("Error in adding Decharge to card");
        return false;
      }

    }catch(e){
      print("Error in adding Decharge to card in Service ${e}");
      return false;
    }
  }
}