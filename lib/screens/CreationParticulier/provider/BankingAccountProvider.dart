import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/Code/Code.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/service/BankingAccountService.dart';

class BankingProvider extends ChangeNotifier {
  BankingAccountModel? BAccount;
  String? pack;
  BankingAccountService bankingAccountService = BankingAccountService();
  List<BankingAccountModel> accounts = [];
  Future<void> addBankingAccount() async {
    try {
      BankingAccountModel account = BankingAccountModel(
        RIB: Code.generateRib(),
        balance: 0.0,
        overDraftAmount: 0.0,
        checkBook: false,
        pack: null,
        accountType: null,
        client: null,
      );
      final result = await bankingAccountService.addBankingAccount(account);
      if (result != null) {
        BAccount = result;
        notifyListeners();
        print("Banking account created with ID :${result.id}");
      }
    } catch (e) {
      print("Error in provider ${e}");
    }
  }

  Future<void> addBankingAccountToClient(String bankingAccountId,
      personId) async {
    try {
      int bankingId = int.parse(bankingAccountId);
      int clientId = int.parse(personId);
      print("Passing client${clientId} to bankingAccount ${bankingId}");
      final result = await bankingAccountService.addBankingAccountToClient(
          bankingId, clientId);
      if (result) {
        print("Successful linking");
        print(
            "banking account ${bankingId} linked to Client ${clientId} successfully");
      }
    } catch (e) {
      print("Error in linking accounts ${e}");
    }
  }

  Future<void> addBankingAccountToAccountType(String bankingAccountId,
      String accountTypeId) async {
    try {
      int bankingId = int.parse(bankingAccountId);
      int accountId = int.parse(accountTypeId);
      print(
          "Passing accountType ${accountId} to bankingAccount ${bankingAccountId}");
      final result = await bankingAccountService.addBankingAccountToAccountType(
          bankingId, accountId);
      if (result) {
        print("Successful linking");
        print(
            "banking account ${bankingId} linked to AccountType ${accountId} successfully");
      }
    } catch (e) {
      print("Error in linking accounts (account type) ${e}");
    }
  }

  Future<void> addBankingAccouuntToAgency(String bankingAccountId,
      String agencyId) async {
    try {
      int bankingId = int.parse(bankingAccountId);
      int agyId = int.parse(agencyId);
      print("Passing Agency ${agyId} to bankingAccount ${bankingAccountId}");
      final result = await bankingAccountService.addBankingAccountToAgency(
          bankingId, agyId);
      if (result) {
        print("Successful linking");
        print(
            "banking account ${bankingId} linked to Agency ${agyId} successfully");
      }
    } catch (e) {
      print("Error in linking accounts (agency) ${e}");
    }
  }

  Future<void> setPackForBanking(String bankingAccountId, String pack)async{
    try{
      int bankingId = int.parse(bankingAccountId);
      await bankingAccountService.setPack(bankingId, pack);
      notifyListeners();
    }catch(e){
      print("Error in set pack provider");
    }
  }

}