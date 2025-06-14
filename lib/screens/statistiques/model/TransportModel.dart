import 'package:pfe_banking_system/screens/statistiques/model/ExpenseModel.dart';

class SoinModel extends ExpenseModel{
  int amount ;
  String type ;
  String name ;
  String date;
  String time;

  SoinModel({
    super.id,
    required this.amount,
    required this.type,
    required this.name,
    required this.date,
    required this.time});

  factory SoinModel.fromJson(Map<String,dynamic> json){
    return SoinModel(
        id:json["id"],
        amount: json["amount"],
        type: json["type"],
        name: json["name"],
        date: json["date"],
        time: json["time"]);
  }

  Map<String , dynamic> toJson()=>{

    'id':id ,
    'amount': amount,
    'type': type,
    'name': name,
    'date': date,
    'time': time
  };
}