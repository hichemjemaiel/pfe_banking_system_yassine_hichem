import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModelDTO.dart';

import '../network/EndPoints.dart';

class BankingAccountDTOService{
  Dio dio = DioClient().dio;

  Future<List<BankingAccountDTOModel>> getAllBankingAccountForClient(int clientId) async{
    try{
      print("fetching Banking Account to Client");
      Response response = await dio.get("${EndPoints.getAllBankingAccountToClient}/${clientId}");
      print("Fetched banking accounts ${response.data}");
      return (response.data as List).map((json) => BankingAccountDTOModel.fromJson(json)).toList();

    }catch(e){
      return [];
    }
  }

  Future<ClientModelDTO?> getClientAssignedToBankingAccount(int BId)async{
    try{
      print("fetching Client assigned for banking account");
      Response response = await dio.get("${EndPoints.getClientAssignedToBankAccount}/${BId}");
      return ClientModelDTO.fromJson(response.data);
    }catch(e){
      print("Error in Bank Account Dto Service ${e}");
    }
  }
}