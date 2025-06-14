import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/FamilleModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/TransportModel.dart';

class FamilleService{
  Dio dio = DioClient().dio;

  Future<Famillemodel?> addFamille(Famillemodel famille)async{
    try{
      print("Passing Famille Model : ${famille.toJson()}");
      Response response = await dio.post("${EndPoints.addFamille}",data: famille.toJson());
      print("Raw api ${response.data}");
      if(response.data != null && response.data is Map<String , dynamic>){
        return Famillemodel.fromJson(response.data);
      }else{
        print("Invalid api Resposne ${response.data}");
      }
    }catch(e){
      print("Error in Famille Service ${e}");
    }
  }
}