import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingModel.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EpargneService.dart';
import 'package:pfe_banking_system/screens/statistiques/service/ShoppingService.dart';

class EpargneProvider extends ChangeNotifier{
  int? amount ;
  String? type;
  String? name ;
  String? date;
  String? time;
  Epargnemodel? epargne;
  EpargneService service = EpargneService();

  void setAmount({required int amount}){
    this.amount = amount;
  }

  void setType(){
    this.type = "Epargne";
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
  Future<void> saveEpargne()async{
    if(amount != null && type != null && name !=null && date != null && time != null){
      try{
        print("Adding Epargne");
        Epargnemodel epargneModel = Epargnemodel(
            amount: amount!,
            type: type!,
            name: name!,
            date: date!,
            time: time!);
        final result = await service.addEpargne(epargneModel);
        if(result != null) {
          epargne = result;
          print("Result added successfully ${epargne?.id}");
        }
      }catch(e){
        print("Error in adding Shopping in Provider ${e}");
      }
    }


  }
}