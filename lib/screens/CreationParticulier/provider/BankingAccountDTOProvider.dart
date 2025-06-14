import 'package:flutter/foundation.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModelDTO.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/service/BankingAccountDTOService.dart';

class BankingAccountDTOProvider extends ChangeNotifier{

  List<BankingAccountDTOModel> accounts = [];
  ClientModelDTO? client;

  BankingAccountDTOService bankingAccountDTOService =BankingAccountDTOService();
  Future<List<BankingAccountDTOModel>> getAllBankingAccountForClient(int clientId)async{
    try{
      print("get all banking accounts for client");
      accounts = await bankingAccountDTOService.getAllBankingAccountForClient(clientId);
      notifyListeners();
      return accounts;
    }catch(e){
      print("Error in get All Banking accounts for client ${e}");
      return [];
    }
  }
  Future<void> getClientAssignedToBankingAccount(int BId)async{
    try{
      print("Fetching client for banking account");
      client = await bankingAccountDTOService.getClientAssignedToBankingAccount(BId);

    }catch(e){
      print("Error in bank account dto provider ${e}");

    }
  }
}