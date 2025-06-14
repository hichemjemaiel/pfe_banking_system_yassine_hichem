import 'package:pfe_banking_system/screens/CreationParticulier/model/AccountTypeModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModel.dart';

class BankingAccountModel{
  final int? id;
  final String? RIB;
  final double balance;
  final double overDraftAmount;
  final bool checkBook;
  final String? pack;
  final String? status;
  final AccountTypeModel? accountType;
  final ClientModel? client;


  BankingAccountModel({
    this.id,
     this.RIB,
    required this.balance,
    required this.overDraftAmount,
    required this.checkBook,
     this.pack,
     this.status ,
    this.accountType,
    this.client});
  factory BankingAccountModel.fromJson(Map<String, dynamic> json) {
    return BankingAccountModel(
      id: json['id'],
      RIB: json['RIB'] ?? json['rib'],
      balance: json['balance'] != null ? json['balance'].toDouble() : 0.0,
      overDraftAmount: json['overDraftAmount'] != null ? json['overDraftAmount'].toDouble() : 0.0,
      checkBook: json['checkBook'] ?? false,
      pack: json['pack'],
      status: json["status"],
      accountType: json['accountType'],
      client: json['client'],
    );
  }

  Map<String, dynamic> toJson() =>{

      'id': id,
      'RIB': RIB,
      'balance': balance,
      'overDraftAmount': overDraftAmount,
      'checkBook': checkBook,
      'pack': pack,
      'status':status,
      'accountType': accountType,
      'client': client,
    };

}