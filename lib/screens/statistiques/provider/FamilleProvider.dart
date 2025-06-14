import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/FamilleModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingModel.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EspecesService.dart';
import 'package:pfe_banking_system/screens/statistiques/service/FamilleService.dart';
import 'package:pfe_banking_system/screens/statistiques/service/ShoppingService.dart';

class FamilleProvider extends ChangeNotifier{
  int? amount ;
  String? type;
  String? name ;
  String? date;
  String? time;
  Famillemodel? famille;
  FamilleService service = FamilleService();

  void setAmount({required int amount}){
    this.amount = amount;
  }

  void setType(){
    this.type = "famille";
  }

  void setName({required String name}){
    this.name = name;
  }

  void setTime({required String time}){
    this.time = time;
  }

  void setDate({required String date}){
    this.date = date;
  }
  Future<void> saveFamille()async{
    if(amount != null && type != null && name !=null && date != null && time != null){
      try{
        print("Adding famille ");
        Famillemodel famillemodel = Famillemodel(
            amount: amount!,
            type: type!,
            name: name!,
            date: date!,
            time: time!);
        final result = await service.addFamille(famillemodel);
        if(result != null) {
          famille = result;
          print("Result added successfully ${famille?.id}");
        }
      }catch(e){
        print("Error in adding famille in Provider ${e}");
      }
    }


  }
}