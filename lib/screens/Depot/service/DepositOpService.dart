import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Depot/model/DepositOpModel.dart';

class DepositOpService{
  Dio dio = DioClient().dio;

  Future<DepositOpModel?> addDepositOp(DepositOpModel depositModel)async{
    try{
      print("Passing depositOp : ${depositModel.toJson()}");
      Response response = await dio.post(EndPoints.addDepositOp,data: depositModel.toJson());
      if(response.data != null && response.data is Map<String , dynamic>){
        print("Raw Response Api : ${response.data}");
        return DepositOpModel.fromJson(response.data);
      }else{
        print("Invalid data format ${response.data}");
        return null;
      }
    }catch(e){
      print("Error in deposit op service ${e}");
      return null;
    }
  }

  Future<bool> addCardToDepositOp(int DepositId , int cardId)async{
      try{
        print("Passsing DepositOp ${DepositId} to Card ${cardId}");
        Response response = await dio.post("${EndPoints.addCardToDepositOp}/${DepositId}/${cardId}");
        if(response.statusCode == 200 || response.statusMessage ==201){
          print("Despoit Op ${DepositId} added to Card ${cardId}");
          return true;
        }else{
          print("Error linking DepositOp to card");
          return false;
        }
      }catch(e){
        print("Error linking in Service ${e}");
        return false;
      }
  }

  Future<bool> addOperateurToDepositOp(int DepositId , int OperatuerId)async{
    try{
      print("Passing DepositOp ${DepositId} to Operateur ${OperatuerId}");
      Response response = await dio.post("${EndPoints.addOperateurToDepositOp}/${DepositId}/${OperatuerId}");
      if(response.statusMessage ==200 || response.statusCode ==201){
        print("Deposit Op ${DepositId} added to Operateur ${OperatuerId}");
        return true;
      }else{
        print("Error in linking to operateur");
        return false;
      }
    }catch(e){
      print("Error in linkling ${e}");
      return false;
    }
  }

  Future<bool> addDepositOpToBankingAccount(int DId , int BId)async{
    try{
      print("Passing DepositOp ${DId} to Banking Account ${BId}");
      Response response = await dio.post("${EndPoints.addDepositOptoBankingAccount}/${DId}/${BId}");
      if(response.statusCode ==200 || response.statusCode ==201){
        print("Deposit Op ${DId} added tp Banking Account ${BId}");
        return true;
      }else{
        print("Error in linking to banking account");
        return false;
      }

    }catch(e){
      print("Error in linking ${e}");
      return false;
    }
  }
}