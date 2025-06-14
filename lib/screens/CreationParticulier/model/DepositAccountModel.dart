import 'package:pfe_banking_system/screens/CreationParticulier/model/AccountTypeModel.dart';

class DepositAccountModel extends AccountTypeModel{
  final String pack;

  DepositAccountModel({
    super.id,
    required this.pack});

  factory DepositAccountModel.fromJson(Map<String , dynamic > json){
    return DepositAccountModel(
        id: json["id"],
        pack: json["pack"]);
  }

  Map<String , dynamic> toJson()=>{
    'id': id,
    'pack':pack

  };
}