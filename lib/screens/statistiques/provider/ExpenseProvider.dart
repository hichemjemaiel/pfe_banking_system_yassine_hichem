import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/MaxBudgetModel.dart';
import 'package:pfe_banking_system/screens/statistiques/service/ExpenseService.dart';

class ExpenseProvider extends ChangeNotifier{
  ExpenseService service =ExpenseService();

  Future<void> addExpenseToBankingAccount(String BId,String EId)async{
     int BankId = int.parse(BId);
      int ExpenseId = int.parse(EId);
     try{
       print("Passing Banking Account ${BankId} to expense ${ExpenseId}");
       final result = await service.addExpenseToBankingAccount(BankId, ExpenseId);
       if(result){
         print("Banking Account ${BankId} added to expense ${ExpenseId} successfully");
         notifyListeners();
       }else{
         print("Failed to pass Banking Account to expense");
       }
     }catch(e){
       print("Failed in Expense Provider ${e}");
     }
  }
}