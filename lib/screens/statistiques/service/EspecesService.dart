import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/TransportModel.dart';

class EspecesService{
  Dio dio = DioClient().dio;

  Future<Especesmodel?> addEspeces(Especesmodel especes)async{
    try{
      print("Passing Especes Model : ${especes.toJson()}");
      Response response = await dio.post("${EndPoints.addEspeces}",data: especes.toJson());
      print("Raw api ${response.data}");
      if(response.data != null && response.data is Map<String , dynamic>){
        return Especesmodel.fromJson(response.data);
      }else{
        print("Invalid api Resposne ${response.data}");
      }
    }catch(e){
      print("Error in Especes Service ${e}");
    }
  }
}