import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/TransportModel.dart';

class TransportService{
  Dio dio = DioClient().dio;

  Future<SoinModel?> addTransport(SoinModel transport)async{
    try{
      print("Passing Transport Model : ${transport.toJson()}");
      Response response = await dio.post("${EndPoints.addTransport}",data: transport.toJson());
      print("Raw api ${response.data}");
      if(response.data != null && response.data is Map<String , dynamic>){
        return SoinModel.fromJson(response.data);
      }else{
        print("Invalid api Resposne ${response.data}");
      }
    }catch(e){
      print("Error in Transport Service ${e}");
    }
  }
}