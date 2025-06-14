import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesModel.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingModel.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EspecesService.dart';
import 'package:pfe_banking_system/screens/statistiques/service/ShoppingService.dart';

class EspecesProvider extends ChangeNotifier{
  int? amount ;
  String? type;
  String? name ;
  String? date;
  String? time;
  Especesmodel? especes;
  EspecesService service = EspecesService();

  void setAmount({required int amount}){
    this.amount = amount;
  }

  void setType(){
    this.type = "especes";
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
  Future<void> saveEspeces()async{
    if(amount != null && type != null && name !=null && date != null && time != null){
      try{
        print("Adding especes");
        Especesmodel especesmodel = Especesmodel(
            amount: amount!,
            type: type!,
            name: name!,
            date: date!,
            time: time!);
        final result = await service.addEspeces(especesmodel);
        if(result != null) {
          especes = result;
          print("Result added successfully ${especes?.id}");
        }
      }catch(e){
        print("Error in adding especes in Provider ${e}");
      }
    }


  }
}