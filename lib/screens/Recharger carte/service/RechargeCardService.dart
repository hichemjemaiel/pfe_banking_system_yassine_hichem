import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/model/RechargeCardModel.dart';

class RechargerCardService {
  Dio dio = DioClient().dio;

  Future<RechargeCardModel?> addRecharge(RechargeCardModel rechargeCard) async {
    try {
      print("Adding Recharge card: ${rechargeCard.toJson()}");

      Response response = await dio.post(
        "${EndPoints.addRechargeCard}",
        data: rechargeCard.toJson(),
      );

      print("Response status code: ${response.statusCode}");
      print("Raw API response: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null) {
          // Handle different response formats
          Map<String, dynamic> responseData;

          if (response.data is Map<String, dynamic>) {
            responseData = response.data;
          } else if (response.data is String) {
            // If response is a string, try to parse it
            print("Response is string, attempting to parse: ${response.data}");
            throw Exception("Unexpected string response from server");
          } else {
            throw Exception("Unexpected response format: ${response.data.runtimeType}");
          }

          // Check if the response contains the data we expect
          if (responseData.containsKey('id')) {
            return RechargeCardModel.fromJson(responseData);
          } else if (responseData.containsKey('data') && responseData['data'] is Map) {
            return RechargeCardModel.fromJson(responseData['data']);
          } else {
            print("Response data doesn't contain expected structure: $responseData");
            throw Exception("Invalid API response structure");
          }
        } else {
          throw Exception("Empty response from server");
        }
      } else {
        throw Exception("Server error: ${response.statusCode} - ${response.statusMessage}");
      }
    } on DioException catch (e) {
      print("Dio error in adding Recharge Card: ${e.message}");
      print("Error type: ${e.type}");
      print("Response: ${e.response?.data}");

      if (e.response != null) {
        throw Exception("Server error: ${e.response!.statusCode} - ${e.response!.data}");
      } else {
        throw Exception("Network error: ${e.message}");
      }
    } catch (e) {
      print("General error in adding Recharge Card in Service: $e");
      throw Exception("Erreur lors de la création de la recharge: $e");
    }
  }

  Future<bool> addRechargeToCard(int RId, int CId) async {
    try {
      print("Adding Recharge $RId to card $CId");

      Response response = await dio.post("${EndPoints.addRechargeToCard}/$RId/$CId");

      print("Response status code: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Recharge $RId added successfully to card $CId");
        return true;
      } else {
        print("Error in adding recharge to card: ${response.statusCode}");
        return false;
      }
    } on DioException catch (e) {
      print("Dio error in adding recharge to card: ${e.message}");
      print("Error type: ${e.type}");
      print("Response: ${e.response?.data}");
      throw Exception("Erreur réseau lors de l'ajout de la recharge à la carte: ${e.message}");
    } catch (e) {
      print("General error in adding recharge to card in Service: $e");
      throw Exception("Erreur lors de l'ajout de la recharge à la carte: $e");
      return false;
    }
  }
}