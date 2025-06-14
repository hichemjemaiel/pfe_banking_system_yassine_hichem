import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingModel.dart';
import 'package:pfe_banking_system/screens/statistiques/service/ShoppingService.dart';

class ShoppingProvider extends ChangeNotifier{
  int? amount ;
  String? type;
  String? name ;
  String? date;
  String? time;
  ShoppingModel? shopping;
  ShoppingService service = ShoppingService();

  void setAmount({required int amount}){
    this.amount = amount;
  }

  void setType(){
    this.type = "Shopping";
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
    Future<void> saveShopping()async{
    if(amount != null && type != null && name !=null && date != null && time != null){
      try{
        print("Adding Shopping");
        ShoppingModel shoppingModel = ShoppingModel(
            amount: amount!,
            type: type!,
            name: name!,
            date: date!,
            time: time!);
        final result = await service.addShopping(shoppingModel);
        if(result != null) {
          shopping = result;
          print("Result added successfully ${shopping?.id}");
        }
      }catch(e){
        print("Error in adding Shopping in Provider ${e}");
      }
    }


    }
}