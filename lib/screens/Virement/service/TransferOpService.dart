import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Virement/model/TransferModel.dart';

class TransferOpService{
  Dio dio = DioClient().dio;

  Future<TransferModel?> addTransferOp(TransferModel transferOp) async {
    try{
      print("Sending TransferOp: ${transferOp.toJson()}");
      Response response = await dio.post("${EndPoints.addTransferOp}", data: transferOp.toJson());

      if(response.data != null && response.data is Map<String, dynamic>){
        print("Raw API Response: ${response.data}");

        // Create a new TransferModel with the API response data
        // But preserve the original date since API doesn't return it
        Map<String, dynamic> responseData = Map<String, dynamic>.from(response.data);

        // Add the original date if it's missing from response
        if (!responseData.containsKey('date')) {
          responseData['date'] = transferOp.date;
        }

        // Add the original namecreditnum if it's missing from response
        if (!responseData.containsKey('namecreditnum')) {
          responseData['namecreditnum'] = transferOp.namecreditnum;
        }

        print("Enhanced response data: $responseData");
        return TransferModel.fromJson(responseData);
      } else {
        print("Error: Invalid response format");
        return null;
      }
    } catch(e) {
      print("Error in Service: $e");
      if (e is DioException) {
        print("DioException details: ${e.response?.data}");
      }
      return null;
    }
  }

  Future<bool> addTransferOpToBankingAccount(int TId, int BId) async {
    try{
      print("Adding TransferOp $TId to banking Account $BId");
      Response response = await dio.post("${EndPoints.addTransferOpToBankingAccount}/$TId/$BId");

      if(response.statusCode == 200 || response.statusCode == 201){
        print("TransferOp $TId added successfully to Banking Account $BId");
        return true;
      } else {
        print("Error in linking TransferOp to BankingAccount. Status: ${response.statusCode}");
        return false;
      }
    } catch(e) {
      print("Error in linking TransferOp to BankingAccount in Service: $e");
      if (e is DioException) {
        print("DioException details: ${e.response?.data}");
      }
      return false;
    }
  }
}