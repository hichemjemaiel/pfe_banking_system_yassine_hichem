import 'package:pfe_banking_system/screens/statistiques/model/ExpenseModel.dart';

class Especesmodel extends ExpenseModel{
  int amount ;
  String type ;
  String name ;
  String date;
  String time;

  Especesmodel({
    super.id,
    required this.amount,
    required this.type,
    required this.name,
    required this.date,
    required this.time});

  factory Especesmodel.fromJson(Map<String,dynamic> json){
    return Especesmodel(
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