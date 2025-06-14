import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/TransportModel.dart';
import 'package:pfe_banking_system/screens/statistiques/service/ShoppingService.dart';
import 'package:pfe_banking_system/screens/statistiques/service/TransportService.dart';

class TransportProvider extends ChangeNotifier{
  int? amount ;
  String? type;
  String? name ;
  String? date;
  String? time;
  SoinModel? transport;
  TransportService service =  TransportService();

  void setAmount({required int amount}){
    this.amount = amount;
  }

  void setType(){
    this.type = "transport";
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
  Future<void> saveTransport()async{
    if(amount != null && type != null && name !=null && date != null && time != null){
      try{
        print("Adding transport");
        SoinModel transportmodel = SoinModel(
            amount: amount!,
            type: type!,
            name: name!,
            date: date!,
            time: time!);
        final result = await service.addTransport(transportmodel);
        if(result != null) {
          transport = result;
          print("Result added successfully ${transport?.id}");
        }
      }catch(e){
        print("Error in adding Transport in Provider ${e}");
      }
    }


  }
}