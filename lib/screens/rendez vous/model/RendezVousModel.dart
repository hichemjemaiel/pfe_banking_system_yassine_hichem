import 'package:pfe_banking_system/screens/CreationParticulier/model/AgencyModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModel.dart';

class RendezVousModel{
  int? id ;
  String date ;
  String time ;
  String objet;
  String commentaire;
  String? status;
  ClientModel? client;
  AgencyModel? agency;

  RendezVousModel({
    this.id,
    required this.date,
    required this.time,
    required this.objet,
    required this.commentaire,
    this.status,
    this.client,
    this.agency});

  factory RendezVousModel.fromJson(Map<String,dynamic> json){
    return RendezVousModel(
      // Map the API response fields to your model fields
        id: json["rendezVousId"] ?? json["id"], // API returns "rendezVousId"
        date: json["date"] ?? "",
        time: json["time"] ?? "",
        objet: json["subject"] ?? json["objet"] ?? "", // API returns "subject"
        commentaire: json["comment"] ?? json["commentaire"] ?? "", // API returns "comment"
        status: json["status"],
        client: json["client"] != null ? ClientModel.fromJson(json["client"]) : null,
        agency: json["agency"] != null ? AgencyModel.fromJson(json["agency"]) : null);
  }

  Map<String,dynamic> toJson()=>{
    'id': id, // Fixed: was 'Id', should be 'id' (lowercase)
    'date': date,
    'time': time,
    'objet': objet,
    'commentaire': commentaire,
    'status': status,
    'client': client?.toJson(), // Fixed: convert to JSON if not null
    'agency': agency?.toJson() // Fixed: convert to JSON if not null
  };
}