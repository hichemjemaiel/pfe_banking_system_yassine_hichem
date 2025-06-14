import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/model/DechargeCardModel.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/service/DechargeCardService.dart';

class DechargeCardProvider extends ChangeNotifier{
  String? creditRib;
  String? banque;
  int? montant;
  String? date;
  String? time;
  DechargeCardService service = DechargeCardService();
  DechargeCardModel? dechargeCard;
  void setCreditRib({required String creditRib}){
    this.creditRib = creditRib;
  }

  void setBanque({required String banque}){
    this.banque = banque;
  }

  void setMontant({required int montant}){
    this.montant = montant;
  }

  void setDate({required String date}){
    this.date = date;
  }

  void setTime({required String time }){
    this.time = time ;
  }
  Future<void> saveDechargeCard(String CId)async{
    int cardId = int.parse(CId);
    if(creditRib!= null && banque!=null && montant!= null){
      try{
        print("Adding Decharge Card");
        DechargeCardModel dechargeCardModel = DechargeCardModel(
            creditRib: creditRib!,
            banque: banque!,
            montant: montant!,
            date: date!,
            time: time!,

        );

        final result = await service.addDecharge(dechargeCardModel,cardId);
        if(result != null){
          dechargeCard = result;
          print("Decharge card added successfullly ${dechargeCard?.id}");
        }
      }catch(e){
        print("Error in adding Decharge in Provider ${e}");
      }
    }


  }

  Future<void> addDechargeCardToCard(String DId ,String CId)async{
    int dechargeId = int.parse(DId);
    int cardId = int.parse(CId);
    try{
      print("Adding Decharge ${dechargeId} to card ${cardId} ");
      final result = await service.addDechargeCardToCard(dechargeId, cardId);
      if(result){
        print("Decharger ${dechargeId} added successfully to Card ${cardId}");
      }
    }catch(e){
      print("Error in adding Decharge to Card in Provider ${e}");
    }
  }
}