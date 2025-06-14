import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountModel.dart';

class ExpenseModel{
   int? id;
   BankingAccountModel? bankingAccountModel;

   ExpenseModel({this.id, this.bankingAccountModel});

   factory ExpenseModel.fromJson(Map<String ,dynamic> json){
      return ExpenseModel(
          id: json["id"],
          bankingAccountModel:json["bankingAccountModel"]);
   }

   Map<String ,dynamic> toJson()=>{
     'id':id,
     'bankingAccountModel':bankingAccountModel
   };


}