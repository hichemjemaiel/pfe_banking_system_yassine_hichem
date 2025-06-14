import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/DepositAccountModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/service/DepositAccountService.dart';

class DepositAccountProvider extends ChangeNotifier{
   String? pack;
   DepositAccountModel? Daccount;
   DepositAccountService depositAccountService = DepositAccountService();
  void setPack({
    required String pack
}){
    this.pack = pack;
  }


  Future<void> saveAccount() async{
    if(pack !=null){
      DepositAccountModel depositAccount = DepositAccountModel(

          pack: pack!);
      try{
        final result = await depositAccountService.addDepositAccount(depositAccount);
        if(result != null){
          Daccount = result;
          print("Deposit Account created with Id : ${result.id}");
        }
        notifyListeners();
      }catch(e){
        print('Error in Deposit Provider ${e}');
      }
    }
  }
   void clearData() {
     pack = null;
     Daccount = null;
     notifyListeners();
   }
}