import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/DepositAccountModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

class DepositAccountService{
  Dio dio = DioClient().dio;
  
  Future<DepositAccountModel?> addDepositAccount(DepositAccountModel account)async{
    try{
      print("passing Deposit account info :${account.toJson()}");
      Response response = await dio.post(EndPoints.addDepositAccount,data: account.toJson());
      if(response.data != null && response.data is Map<String , dynamic>){
        print("RAW Api respone : ${response.data}");
        return DepositAccountModel.fromJson(response.data);
      }else{
        print("Invalid format Api : ${response.data}");
        return null;
      }
    }catch(e){
      print("Error in Deposit Service ${e}");
    }
  }

  


}