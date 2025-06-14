import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/SavingAccountModel.dart';

import '../../CreationEntreprise/network/DioClient.dart';
import '../network/EndPoints.dart';

class SavingAccountService{
  Dio dio = DioClient().dio;

  Future<SavingAccountModel?> addSavingAccount(SavingAccountModel account)async{
    try{
      print("passing Saving account info :${account.toJson()}");
      Response response = await dio.post(EndPoints.addSavingAccount,data: account.toJson());
      if(response.data != null && response.data is Map<String , dynamic>){
        print("RAW Api respone : ${response.data}");
        return SavingAccountModel.fromJson(response.data);
      }else{
        print("Invalid format Api : ${response.data}");
        return null;
      }
    }catch(e){
      print("Error in Saving Service ${e}");
    }
  }


}