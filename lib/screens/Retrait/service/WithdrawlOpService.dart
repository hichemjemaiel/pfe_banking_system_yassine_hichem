import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Retrait/model/WithdrawlOp.dart';

class WithdrawlOpService{
  Dio dio = DioClient().dio;

  Future<WithdrawlOpModel?> addWithdrawlOp(WithdrawlOpModel witdrawlop) async {
    try {
      print("passing witwdrawlOp ${witdrawlop.toJson()}");
      Response response = await dio.post("${EndPoints.addWithdrawlOp}", data: witdrawlop.toJson());

      if (response.data != null && response.data is Map<String, dynamic>) {
        print("Raw Response Api : ${response.data}");

        // Create a new WithdrawlOpModel with the response data and original request data
        return WithdrawlOpModel(
            id: response.data["withdrawalId"], // Get ID from API response
            montant: response.data["amount"] ?? witdrawlop.montant, // Use API amount or fallback to original
            date: witdrawlop.date, // Keep original date
            status: response.data["status"] ?? witdrawlop.status, // Use API status or fallback
            creditnum: witdrawlop.creditnum, // Keep original creditnum
            namecreditnum: witdrawlop.namecreditnum, // Keep original namecreditnum
            operateur: witdrawlop.operateur // Keep original operateur
        );
      } else {
        print("Invalid data format ${response.data}");
        return null;
      }
    } catch (e) {
      print("Error in creating WithdrawlOp Service ${e}");
      return null;
    }
  }

  Future<bool> addWithdarwlOptOperateur(int WId , int OId)async{
    try{
      print("passing WithdrawlOp ${WId} to Operateur ${OId}");
      Response response = await dio.post("${EndPoints.addOperateurToWithdrawlOp}/${WId}/${OId}");
      if(response.statusCode == 200 || response.statusCode ==201){
        print("WithdrawlOp ${WId} added to operatuer ${OId} successfully");
        return true;
      }else{
        print("Error in linking withdrawl op to operateur");
        return false;
      }
    }catch(e){
      print("Error in linking withdrawl op to operateur in Service ${e}");
      return false;
    }
  }

  Future<bool> addWithdrawlOpToBankingAccount(int WId , int BId)async{
    try{
      print("passing withdarwlOp ${WId} to bankingAccount ${BId}");
      Response response = await dio.post("${EndPoints.addWithdrawlOpToBankingAccount}/${WId}/${BId}");
      if(response.statusCode ==200 || response.statusCode ==201){
        print("Withdrawl ${WId} linked successfully to Banking Account ${BId}");
        return true;
      }else{
        print("Error in linking withdrawl op to banking account");
        return false;
      }
    }catch(e){
      print("Error in linking withdrawlOp to Banking account in Service ${e}");
      return false;
    }
  }
}