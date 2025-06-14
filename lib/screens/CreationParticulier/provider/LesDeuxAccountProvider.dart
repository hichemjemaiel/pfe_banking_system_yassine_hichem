import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/LesDeuxAccountModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/service/LesDeuxAccountService.dart';

class LesDeuxAccountProvider extends ChangeNotifier{
  String? pack;
  LesDeuxAccountModel? Laccount;
  LesDeuxAccountService lesDeuxAccountService = LesDeuxAccountService();
  void setPack({
    required String pack
  }){
    this.pack = pack;
  }


  Future<void> saveAccount() async{
    if(pack !=null){
      LesDeuxAccountModel LesDeuxAccount = LesDeuxAccountModel(

          pack: pack!);
      try{
        final result = await lesDeuxAccountService.addLesDeuxAccount(LesDeuxAccount);
        if(result != null){
          Laccount = result;
          print("Les Deux Account created with Id : ${result.id}");
        }
        notifyListeners();
      }catch(e){
        print('Error in Les Deux Account Provider ${e}');
      }
    }
  }
  void clearData() {
    pack = null;
    Laccount = null;
    notifyListeners();
  }
}