import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

class BankingAccountService{
  Dio dio = DioClient().dio;

  Future<BankingAccountModel?> addBankingAccount(BankingAccountModel account)async{
    try{
      print("passing Banking account : ${account.toJson()}");
      Response response = await dio.post(EndPoints.addBankingAccount,data: account.toJson());
      if(response.data != null && response.data is Map<String, dynamic>){
        print("RAW API response : ${response.data}");
        return BankingAccountModel.fromJson(response.data);

      }else{
        print("Invalid data format ${response.data}");
        return null;
      }
    }catch(e){
      print("Error in Banking Service ${e}");
      return null;
    }
  }

  Future<bool> addBankingAccountToClient(int BankingAccountId , int ClientId)async{
    try{
      print("Passing client${ClientId} to bankingAccount ${BankingAccountId}");

      Response response = await dio.post("${EndPoints.addBankingAccountToClient}/${BankingAccountId}/${ClientId}");
      if (response.statusCode ==200 || response.statusCode ==201) {
        print("banking account ${BankingAccountId} linked to Client ${ClientId} successfully");
        return true;
      }else{
        print("Error linking banking account to client ");
        return false;
      }
    }catch(e){
      print("Error in Banking To Client ${e}");
      return false;
      }
  }

  Future<bool> addBankingAccountToAccountType(int BankingAccountId , int AccountTypeId)async{
    try{
      print("Passing AccountType ${AccountTypeId} to BankingAccount ${BankingAccountId}");
      Response response = await dio.post("${EndPoints.addBankingAccountToType}/${BankingAccountId}/${AccountTypeId}");
      if(response.statusCode ==200 || response.statusCode ==201){
        print("banking account ${BankingAccountId} linked to account type ${AccountTypeId}");
        return true;
      }else{
        print("Error linking banking account to account type");
        return false;
      }
    }catch(e){
      print("Error in Banking to Account type Service ${e}");
      return false;
    }
  }

  Future<bool> addBankingAccountToAgency(int BankingAccountId , int AgencyId)async{
    try{
      print("Passing Agency ${AgencyId} to banking Account ${BankingAccountId}");
      Response response = await dio.post("${EndPoints.addBankingAccountToAgency}/${BankingAccountId}/${AgencyId}");
      if(response.statusCode ==200 || response.statusMessage ==201){
        print("banking account ${BankingAccountId} linked to agency ${AgencyId}");
        return true;
      }else{
        print("Error linking banking account to agency");
        return false;
      }
    }catch(e){
      print("Error in Banking to Agency Service ${e}");
      return false;
    }
  }

  Future<void> setPack(int BankingId , String pack)async{
    try{
      Response response = await dio.put("${EndPoints.updatePackforBankingAccount}/${BankingId}/${pack}");

    }catch(e){
      print("Error in Banking Service setPack method ${e}");
    }
  }
}