import 'package:pfe_banking_system/screens/Recharger%20carte/model/CardHistoryModel.dart';

class DechargeCardModel extends CardHistoryModel{
  String creditRib ;
  String banque ;
  int montant;
  String date ;
  String time ;
  DechargeCardModel({
    super.id,
    required this.creditRib,
    required this.banque,
    required this.montant,
    required this.date,
    required this.time,
  });

  factory DechargeCardModel.fromJson(Map<String , dynamic> json){
    return DechargeCardModel(
        id: json["id"],
        creditRib: json["creditRib"],
        banque: json["banque"],
        montant: json["montant"] is String ? int.parse(json["montant"]) : json["montant"],
        date: json["date"],
        time : json["time"]
    );
  }

  Map<String , dynamic> toJson()=>{
        "id":id,
        "creditRib": creditRib,
        "banque": banque,
        "montant": montant,
        "date" : date,
        "time" : time
  };
}