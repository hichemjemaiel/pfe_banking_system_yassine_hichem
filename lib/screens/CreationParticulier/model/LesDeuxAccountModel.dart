import 'package:pfe_banking_system/screens/CreationParticulier/model/AccountTypeModel.dart';

class LesDeuxAccountModel extends AccountTypeModel{
  final String pack;

  LesDeuxAccountModel({
    super.id,
    required this.pack});

  factory LesDeuxAccountModel.fromJson(Map<String , dynamic > json){
    return LesDeuxAccountModel(
        id: json["id"],
        pack: json["pack"]);
  }

  Map<String , dynamic> toJson()=>{
    'id': id,
    'pack':pack

  };
}