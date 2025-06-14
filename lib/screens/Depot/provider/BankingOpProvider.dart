import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Depot/service/BankingOpService.dart';

class BankingOpProvider extends ChangeNotifier{
  BankingOpService bankingOpService = BankingOpService();

  Future<void> addBankingOperationToAgency(String BankinOpId , String AgencyId)async{
    int BankOpId = int.parse(BankinOpId);
    int AgcId = int.parse(AgencyId);
    try{
      print("Passing Banking Operation ${BankinOpId} to Agency ${AgcId}");
      final result = await bankingOpService.addBankingOperationToAgency(BankOpId, AgcId);
      if(result){
        print("linking successfully");
        print("Banking Op ${BankinOpId} linked to Agency ${AgcId} successfully");
      }else{
        print("Error in linking");
      }
    }catch(e){
      print("Error in linking ${e}");
    }
  }

  Future<void> addBankingOperationToBankingAccount(String BankingOpId , String BankingAccountId)async{
    int BankOpId = int.parse(BankingOpId);
    int BankId = int.parse(BankingAccountId);
    try{
      print("Passing Banking Operation ${BankingOpId} to Banking Account ${BankId}");
      final result = await bankingOpService.addBankingOperationToBankingAccount(BankOpId, BankId);
      if(result){
        print("linking successfully");
        print("Banking Op ${BankingOpId} linked to BankingAccount ${BankId}");
      }
    }catch(e){
      print("Error in linking ${e}");
    }
  }
}