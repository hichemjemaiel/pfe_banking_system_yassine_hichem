import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModel.dart';

class ReclamationModel{
  int? id ;
  String type;
  String objet;
  String description;
  String date ;
  String time;
  String status;
  ClientModel? client;

  ReclamationModel({
      this.id,
      required this.type,
      required this.objet,
      required this.description,
      required this.date,
      required this.time,
      required this.status,
      this.client}
      );

  factory ReclamationModel.fromJson(Map<String , dynamic> json){
    return ReclamationModel(
        id: json["id"],
        type: json["type"],
        objet: json["objet"],
        description: json["description"],
        date: json["date"],
        time: json["time"],
        status: json["status"],
        client: json["client"]
    )   ;
  }

  Map<String , dynamic> toJson()=>{

        'id':id ,
        'type': type,
        'objet': objet,
        'description': description,
        'date': date,
        'time': time,
        'status': status,
       'client': client

  };
}