import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/TransportModel.dart';
import 'package:pfe_banking_system/screens/statistiques/service/ShoppingService.dart';
import 'package:pfe_banking_system/screens/statistiques/service/SoinService.dart';
import 'package:pfe_banking_system/screens/statistiques/service/TransportService.dart';

class SoinProvider extends ChangeNotifier{
  int? amount ;
  String? type;
  String? name ;
  String? date;
  String? time;
  SoinModel? soin;
  SoinService service =  SoinService();

  void setAmount({required int amount}){
    this.amount = amount;
  }

  void setType(){
    this.type = "soin";
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
  Future<void> saveSoin()async{
    if(amount != null && type != null && name !=null && date != null && time != null){
      try{
        print("Adding Soin");
        SoinModel soinModel = SoinModel(
            amount: amount!,
            type: type!,
            name: name!,
            date: date!,
            time: time!);
        final result = await service.addSoin(soinModel);
        if(result != null) {
          soin = result;
          print("Result added successfully ${soin?.id}");
        }
      }catch(e){
        print("Error in adding Transport in Provider ${e}");
      }
    }


  }
}