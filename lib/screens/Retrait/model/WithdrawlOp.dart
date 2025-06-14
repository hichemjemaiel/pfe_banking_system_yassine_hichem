import 'package:pfe_banking_system/screens/Depot/model/BankingOperationModel.dart';
import 'package:pfe_banking_system/screens/Depot/model/OperateurModel.dart';

class WithdrawlOpModel extends BankingOperationModel{

  final int montant;
  final String date;
  final String? creditnum;
  final String? namecreditnum;
  final OperateurModel? operateur;

  WithdrawlOpModel({
    super.id,
    required this.montant,
    required this.date,
    required super.status,
    required this.creditnum,
    required this.namecreditnum,
    this.operateur});

  factory WithdrawlOpModel.fromJson(Map<String , dynamic> json){
    // Handle the actual API response format
    return WithdrawlOpModel(
      // Map 'withdrawalId' to 'id'
        id: json["withdrawalId"] ?? json["id"],
        // Map 'amount' to 'montant'
        montant: json["amount"] ?? json["montant"],
        // For date, you'll need to provide it since API doesn't return it
        // You can either pass it from the original request or generate it
        date: json["date"] ?? DateTime.now().toString(),
        // API returns status in French, keep as is
        status: json["status"],
        // These won't be in API response, so keep originals from request
        creditnum: json["creditnum"],
        namecreditnum: json["namecreditnum"],
        operateur: json["operateur"]
    );
  }

  Map<String , dynamic> toJson()=>{
    'id':id,
    'montant': montant,
    'date': date,
    'status': status,
    'creditnum': creditnum,
    'namecreditnum': namecreditnum,
    'operateur' : operateur
  };
}