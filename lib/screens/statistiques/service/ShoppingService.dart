import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingModel.dart';

class ShoppingService{
  Dio dio = DioClient().dio;

  Future<ShoppingModel?> addShopping(ShoppingModel shopping)async{
    try{
      print("Passing Shopping Model : ${shopping.toJson()}");
      Response response = await dio.post("${EndPoints.addShopping}",data: shopping.toJson());
      print("Raw api ${response.data}");
      if(response.data != null && response.data is Map<String , dynamic>){
        return ShoppingModel.fromJson(response.data);
      }else{
        print("Invalid api Resposne ${response.data}");
      }
    }catch(e){
      print("Error in Shopping Service ${e}");
    }
  }
}