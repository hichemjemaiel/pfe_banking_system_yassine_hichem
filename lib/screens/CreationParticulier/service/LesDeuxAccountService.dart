import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/LesDeuxAccountModel.dart';

import '../../CreationEntreprise/network/DioClient.dart';
import '../network/EndPoints.dart';

class LesDeuxAccountService{
  Dio dio = DioClient().dio;

  Future<LesDeuxAccountModel?> addLesDeuxAccount(LesDeuxAccountModel account)async{
    try{
      print("passing LesDeux Account account info :${account.toJson()}");
      Response response = await dio.post(EndPoints.addLesDeuxAccount,data: account.toJson());
      if(response.data != null && response.data is Map<String , dynamic>){
        print("RAW Api respone : ${response.data}");
        return LesDeuxAccountModel.fromJson(response.data);
      }else{
        print("Invalid format Api : ${response.data}");
        return null;
      }
    }catch(e){
      print("Error in Les Deux Account Service ${e}");
    }
  }
}