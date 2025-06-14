import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingModel.dart';

class EpargneService{
  Dio dio = DioClient().dio;

  Future<Epargnemodel?> addEpargne(Epargnemodel epargne)async{
    try{
      print("Passing Epargne Model : ${epargne.toJson()}");
      Response response = await dio.post("${EndPoints.addEpargne}",data: epargne.toJson());
      print("Raw api ${response.data}");
      if(response.data != null && response.data is Map<String , dynamic>){
        return Epargnemodel.fromJson(response.data);
      }else{
        print("Invalid api Resposne ${response.data}");
      }
    }catch(e){
      print("Error in Epargne Service ${e}");
    }
  }
}