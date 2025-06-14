import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/historique/model/BankOpDTO.dart';

class BankOpdtoService{
  Dio dio = DioClient().dio;

  Future<List<BankOpDTO>> getAllBankingOpsForBankAccount(int BankId)async{
    try{
      print("fetching Banking Operations for banking account");
      Response response = await dio.get("${EndPoints.getAllBankingOpsforBankAccount}/${BankId}");
      print("Banking Operations ${response.data}");
      return (response.data as List).map((json) => BankOpDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in Service getAllBankingOps for Bank Account${e}");
      return [];
    }
  }

  Future<List<BankOpDTO>> getAllBankingOpsForBankAccountByType(int BankId, String type)async{
      try{
        print("fetching Banking Operations for banking account per type");
        Response response = await dio.get("${EndPoints.getAllBankingOpsforBankAccountByType}/${BankId}/${type}");
        print("Banking Opertaions ${response.data}");
        return (response.data as List).map((json) => BankOpDTO.fromJson(json)).toList();
      }catch(e){
        print("Error in Service getAllBankingOps for Bank Account By Type ${e}");
        return [];
      }
  }

  Future<List<BankOpDTO>> getAllBankingOperationsForBankAccountByRIB(String RIB)async{
    try{

      print("fetching Bank Operations for banking account per RIB");
      Response response = await dio.get("${EndPoints.getAllBankingOpsforBankAccountByRIB}/${RIB}");
      print("Banking operations ${response.data}");
      return (response.data as List).map((json) => BankOpDTO.fromJson((json))).toList();
    }catch(e){
        print("Error in Service getAllBankingOps by RIB ${e}");
        return [];
    }
  }

  Future<List<BankOpDTO>> getAllReceivedTransferForBankingAccount(String receiverRIB)async{
    try{

      print("fetching Recieved Transfers for Banking Account by RIB");
      Response response = await dio.get("${EndPoints.getAllReceivedTransferForBankingAccount}/${receiverRIB}");
      print("Banking Transfers ${response.data}");
      return (response.data as List).map((json) => BankOpDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in Service getAllReceived All Transfers ${e}");
      return [];
    }
  }

  Future<List<BankOpDTO>> getAllTransactionsForBankAccountByMonth(int BankId ,String type,String month)async{
    try{
        print("Fethcing All Transactions for Banking account by month :");
        Response response = await dio.get("${EndPoints.getAllTransactionsForBankAccountByMonth}/${BankId}/${type}/${month}");
        print("Banking Transactions ${response.data}");
        return (response.data as List).map((json) => BankOpDTO.fromJson(json)).toList();
    }catch(e){
      print("Error in Banking All Transactions ${e}");
      return [];
    }
  }

  Future<int?> getAmountForBankAccountByMonth(int BankId,String type, String month)async{
    try{
      print("Amount : ");
      Response response = await dio.get("${EndPoints.getAllAmountsForBankAccountByMonth}/${BankId}/${type}/${month}");
      return response.data as int;
    }catch(e){
      print("Error in Banking Amount ${e}");

    }
  }
}