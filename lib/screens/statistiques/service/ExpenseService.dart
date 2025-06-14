import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

class ExpenseService{
  Dio dio = DioClient().dio;

  Future<bool> addExpenseToBankingAccount(int BId , int EId)async{
    try{
      print("Passing Expense ${EId} to banking Account ${BId} ");
      Response response = await dio.post("${EndPoints.addExpenseToBankingAccount}/${BId}/${EId}");
      print("linking Expense ${EId} to banking Account ${BId}");
      if(response.statusCode ==200 || response.statusCode==201){
        return true;
      }else{
        print("Error in linking");
        return false;
      }
    }catch(e){
      print("Error in linking Expense to Bank Account${e}");
      return false;
    }
  }
}