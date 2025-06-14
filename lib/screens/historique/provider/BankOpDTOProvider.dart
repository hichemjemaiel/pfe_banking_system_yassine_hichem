import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/historique/model/BankOpDTO.dart';
import 'package:pfe_banking_system/screens/historique/service/BankOpdtoService.dart';

class BankOpDTOProvider extends ChangeNotifier{
  List<BankOpDTO> operations = [];
  List<BankOpDTO> operationsType =[];
  List<BankOpDTO> operationsByRIB = [];
  List<BankOpDTO> operationsReceived = [];
  List<BankOpDTO> operationMonth = [];
  int? amount ;
  BankOpdtoService service =BankOpdtoService();

  Future<List<BankOpDTO>> getAllBankingOpsForBankAccount(int BankId)async{
    try{
      print("Fetching operations");
      operations = await service.getAllBankingOpsForBankAccount(BankId);
      print("operations fetched successfully");
      notifyListeners();
      return operations;
    }catch(e){
      print("Error in Provider ${e}");
      notifyListeners();
      return [];
    }

  }

  Future<List<BankOpDTO>> getAllBankingOpsForBankAccountByType(int BankId, String type)async{
    try{
      print("Fetching operations");
      operationsType = await service.getAllBankingOpsForBankAccountByType(BankId, type);
      print("operations fetched successfully");
      notifyListeners();
      return operationsType;
    }catch(e){
      print("Error in Provider ${e}");
      notifyListeners();
      return [];
    }

  }

  Future<List<BankOpDTO>> getAllBankingOperationsForBankAccountByRIB(String RIB)async{
    try{
      print("Fetching operations");
      operationsByRIB = await service.getAllBankingOperationsForBankAccountByRIB(RIB);
      notifyListeners();
      return operationsByRIB;
    }catch(e){
      print("Error in Provider ${e}");
      return [];
    }
  }

  Future<List<BankOpDTO>> getAllReceivedTransferForBankingAccountByRIB(String RIB)async{
    try{
      print("Fetching operations");
      operationsReceived = await service.getAllReceivedTransferForBankingAccount(RIB);
      notifyListeners();
      return operationsReceived;
    }catch(e){
      print("Error in Provider ${e}");
      return [];
    }
  }

  Future<List<BankOpDTO>> getAllTransactionsForBankAccountByMonth(int BankId , String type , String month)async{
    try{
      print("fetching operations ");
      operationMonth = await service.getAllTransactionsForBankAccountByMonth(BankId, type, month);
      notifyListeners();
      return operationMonth;
    }catch(e){
      print("Error in Provider ${e}");
      return [];
    }
  }

  Future<int?> getAmountForBankAccountByMonth(int BankId, String type, String month)async{
    try{
      amount = await service.getAmountForBankAccountByMonth(BankId, type, month);
      notifyListeners();
      return amount;
    }catch(e){
      print("Error in Provider ${e}");
    }
  }
}