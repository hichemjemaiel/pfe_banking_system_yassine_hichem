import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModel.dart';

class ContactModel{
  int? id ;
  String type;
  String nom ;
  String adresse;
  String categorie;
  String rib ;
  String intitule;
  ClientModel? clientModel;

  ContactModel({
    this.id,
    required this.type,
    required this.nom,
    required this.adresse,
    required this.categorie,
    required this.rib,
    required this.intitule,
    this.clientModel});

  factory ContactModel.fromJson(Map<String , dynamic> json){
    return ContactModel(
        id: json["id"],
        clientModel: json["clientModel"],
        type: json["type"],
        nom: json["nom"],
        adresse: json["adresse"],
        categorie: json["categorie"],
        rib: json["rib"],
        intitule: json["intitule"]);
  }

  Map<String,dynamic> toJson()=>{
        'clientModel':clientModel,
        'type': type,
        'nom': nom,
        'adresse': adresse,
        'categorie': categorie,
        'rib': rib,
        'intitule': intitule
  };
}