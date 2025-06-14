import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModel.dart';

class CardModel{
  int? id ;
  String type ;
  String name ;
  String number;
  String expirationDate;
  ClientModel? client;
  int balance;
  String status;
  CardModel({
    this.id,
    required this.type,
    required this.name,
    required this.number,
    required this.expirationDate,
    this.client,
    required this.balance,
    required this.status,
  });

  factory CardModel.fromJson(Map<String , dynamic> json){
    return CardModel(
        id : json["id"],
        type: json["type"],
        name: json["name"],
        number: json["number"],
        expirationDate: json["expirationDate"],
        client: json["client"],
        balance: json["balance"] is String ? int.parse(json["balance"]) : json["balance"],
        status: json["status"]
    );
  }

  Map<String, dynamic> toJson()=>{

        "id": id,
        "type": type,
        "name": name,
        "number": number,
        "expirationDate": expirationDate,
        "client":client,
        "balance":balance,
        "status":status

  };
}