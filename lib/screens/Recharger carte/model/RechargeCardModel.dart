import 'package:pfe_banking_system/screens/Recharger%20carte/model/CardHistoryModel.dart';

class RechargeCardModel  extends CardHistoryModel{
  String debitRib;
  String  banque;
  String nom ;
  int montant;
  String date ;
  String time ;
  RechargeCardModel({
    super.id,
    required this.debitRib,
    required this.banque,
    required this.nom,
    required this.montant,
    required this.date,
    required this.time
  });

  factory RechargeCardModel.fromJson(Map<String , dynamic> json){
    return RechargeCardModel(
        id:json["id"],
        debitRib: json["debitRib"],
        banque: json["banque"],
        nom: json["nom"],
        montant: json["montant"] is String ? int.parse(json["montant"]) : json["montant"],
        date: json["date"],
        time : json["time"]
    );

  }

  Map<String , dynamic> toJson()=>{
        "id":id ,
        "debitRib": debitRib,
        "banque": banque,
        "nom": nom,
        "montant": montant,
        "date" : date,
        "time" : time
  };
}