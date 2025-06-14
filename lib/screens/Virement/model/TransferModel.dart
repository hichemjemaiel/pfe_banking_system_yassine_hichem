import 'package:pfe_banking_system/screens/Depot/model/BankingOperationModel.dart';

class TransferModel extends BankingOperationModel{
  int montant ;
  String date ;
  String senderRIB;
  String receiverRIB;
  String namecreditnum;

  TransferModel({
    super.id,
    required this.montant,
    required this.date,
    required super.status,
    required this.senderRIB,
    required this.receiverRIB,
    required this.namecreditnum
  });

  factory TransferModel.fromJson(Map<String,dynamic> json){
    print("Parsing JSON: $json"); // Debug log

    return TransferModel(
      // Fix: Use "transferId" from API response instead of "id"
        id: json["transferId"] ?? json["id"],
        montant: json["amount"] ?? json["montant"] ?? 0,
        date: json["date"] ?? "",
        status: json["status"] ?? "PENDING",
        senderRIB: json["senderRIB"] ?? "",
        receiverRIB: json["receiverRIB"] ?? "",
        namecreditnum: json["namecreditnum"] ?? json["note"] ?? ""
    );
  }

  Map<String , dynamic> toJson()=>{
    'id': id,
    'montant': montant,
    'date': date,
    'status': status,
    'senderRIB': senderRIB,
    'receiverRIB': receiverRIB,
    'namecreditnum': namecreditnum
  };
}