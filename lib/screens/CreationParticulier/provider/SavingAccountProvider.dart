import 'package:flutter/material.dart';

import '../model/SavingAccountModel.dart';
import '../service/SavingAccountService.dart';

class SavingAccountProvider extends ChangeNotifier{
  String? pack;
  SavingAccountModel? Saccount;
  SavingAccountService savingAccountService = SavingAccountService();
  void setPack({
    required String pack
  }){
    this.pack = pack;
  }


  Future<void> saveAccount() async{
    if(pack !=null){
      SavingAccountModel savingAccount = SavingAccountModel(

          pack: pack!);
      try{
        final result = await savingAccountService.addSavingAccount(savingAccount);
        if(result != null){
          Saccount = result;
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
    Saccount = null;
    notifyListeners();
  }
}