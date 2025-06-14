import 'package:pfe_banking_system/screens/CreationParticulier/model/AccountTypeModel.dart';

class SavingAccountModel extends AccountTypeModel{
  final String pack;

    SavingAccountModel({
    super.id,
    required this.pack});

  factory SavingAccountModel.fromJson(Map<String , dynamic > json){
    return SavingAccountModel(
        id: json["id"],
        pack: json["pack"]);
  }

  Map<String , dynamic> toJson()=>{
    'id': id,
    'pack':pack

  };
}