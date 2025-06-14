import 'package:pfe_banking_system/screens/Depot/model/CardModel.dart';

class CardHistoryModel {
  int? id ;
  CardModel? card;

  CardHistoryModel({this.id,  this.card});

  factory CardHistoryModel.fromJson(Map<String , dynamic> json){
    return CardHistoryModel(
        id: json["id"],
        card: json["card"] != null ? CardModel.fromJson(json["card"]) : null,);
  }

  Map<String , dynamic> toJson()=>{
    "id":id,
    "card" : card
  };
}