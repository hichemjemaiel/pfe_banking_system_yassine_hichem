import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

class BankingOpService{
  Dio dio = DioClient().dio;

  Future<bool> addBankingOperationToAgency(int BankOpId ,int AgencyId)async{
    try{
      print("Passing BankingOp :${BankOpId} to Agency : ${AgencyId}");
      Response response = await dio.post("${EndPoints.addBankingOperationToAgency}/${BankOpId}/${AgencyId}");
      if(response.statusCode == 200 || response.statusCode ==201){
        print("BankingOp ${BankOpId} added successfully to Agency ${AgencyId}");
        return true;
      }else{
        print("Error linking BankigOp to Agency");
        return false;
      }
    }catch(e){
      print("Error linking in Service ${e}");
      return false;
    }
  }

  Future<bool> addBankingOperationToBankingAccount(int BankOpId , int BankA)async{
    try{
      print("Passing BankingOp :${BankOpId} to BankingAccount :${BankA}");
      Response response = await dio.post("${EndPoints.addBankingOperationToBankingAccount}/${BankOpId}/${BankA}");
      if(response.statusCode ==200 || response.statusCode ==201){
        print("Banking Op ${BankOpId} added to Banking Account ${BankA}");
        return true;
      }else{
        print("Error linking BankigOp to Banking Account");
        return false;
      }
    }catch(e){
      print("Error linking in Service ${e}");
      return false;
    }
  }
}