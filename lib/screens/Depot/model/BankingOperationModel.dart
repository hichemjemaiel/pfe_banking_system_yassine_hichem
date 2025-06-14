import 'package:pfe_banking_system/screens/CreationParticulier/model/AgencyModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountModel.dart';

class BankingOperationModel{
  final int? id ;
  final String status;
  final BankingAccountModel? bankingAccountModel;
  final AgencyModel? agencyModel;

  BankingOperationModel(
      {this.id,
        required this.status,
         this.bankingAccountModel,
         this.agencyModel});

  factory  BankingOperationModel.fromJson(Map<String , dynamic> json){
    return BankingOperationModel(
        id: json["id"],
        status: json["status"],
        bankingAccountModel: json["bankingAccountModel"],
        agencyModel: json["agencyModel"]);
  }

  Map<String , dynamic> toJson()=>{
      'id': id,
      'status' :status,
      'bankingAccountModel': bankingAccountModel,
      'agencyModel': agencyModel
  };
}