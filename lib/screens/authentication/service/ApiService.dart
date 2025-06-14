import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:pfe_banking_system/screens/authentication/model/AuthResponse.dart';
import 'package:pfe_banking_system/screens/authentication/model/LoginRequest.dart';
import 'package:pfe_banking_system/screens/authentication/model/RegisterRequest.dart';
import 'package:pfe_banking_system/screens/authentication/model/User.dart';
import 'dart:convert';

class ApiService{
  Dio dio = DioClient().dio;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await storage.write(key: "jwt_token", value: token);
  }

  Future<String?> getToken()async{
    return await storage.read(key: "jwt_token");
  }

  Future<void> deleteToken()async{
    await storage.delete(key: "jwt_token");
  }

  Future<String?> register(RegisterRequest request)async{
    try{
      Response response = await dio.post("${EndPoints.register}",data:request.toJson());
      return response.data;
    }catch(e){
      print("Error in registering Service ${e}");
      rethrow; // Important: rethrow to let the provider handle the error
    }
  }

  // Add this new method for setting password
  Future<String?> setPassword(LoginRequest request)async{
    try{
      Response response = await dio.put("${EndPoints.setPassword}",data:request.toJson());
      return response.data;
    }catch(e){
      print("Error in setting password Service ${e}");
      rethrow; // Important: rethrow to let the provider handle the error
    }
  }

  Future<String?> login(LoginRequest request) async {
    try {
      Response response = await dio.post("${EndPoints.authenticate}", data: request.toJson());

      // If the response has a token, save it and return it
      if (response.data != null && response.data["token"] != null) {
        await storage.write(key: "jwt_token", value: response.data["token"]);
        return response.data["token"];
      } else {
        throw Exception("Authentication failed: No token received");
      }
    } catch (e) {
      // Handle DioError specifically
      if (e is DioException) {
        // Access the error response data if available
        if (e.response != null && e.response!.data != null) {
          String errorMessage = e.response!.data["message"] ?? "Login failed";
          throw Exception(errorMessage);
        } else {
          throw Exception("Connection error: ${e.message}");
        }
      }
      // Handle any other exceptions
      throw Exception("Login failed: ${e.toString()}");
    }
  }

  Future<void> logout()async{
    await deleteToken();
  }

  Future<bool> resetPassword(LoginRequest request)async{
    try{
      print("Resetting password: ");
      Response response = await dio.put("${EndPoints.resetPassword}",data: request.toJson());
      if(response.statusCode == 200 || response.statusCode ==201){
        print("Password reset successfully");
        return true;
      }else{
        print("Error in resetting password");
        return false;
      }
    }catch(e){
      print("Error in resetting password in Service ${e}");
      return false;
    }
  }

  // Original getUser method (keeping it for backwards compatibility)
  Future<User?> getUser(String email) async {
    try {
      print("🔍 Fetching user with email: $email");
      print("🔍 Using endpoint: ${EndPoints.findUser}/$email");

      Response response = await dio.get("${EndPoints.findUser}/$email");

      print("🔍 Response status: ${response.statusCode}");
      print("🔍 Response data type: ${response.data.runtimeType}");

      // Check if response is successful
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Log the raw response for debugging
        print("🔍 Raw response data: ${response.data}");

        if (response.data != null) {
          // Check if it's already a Map or if it's a String that needs parsing
          if (response.data is Map<String, dynamic>) {
            return User.fromJson(response.data);
          } else if (response.data is String) {
            // Try to parse the string as JSON
            try {
              var jsonData = json.decode(response.data);
              if (jsonData is Map<String, dynamic>) {
                return User.fromJson(jsonData);
              }
            } catch (parseError) {
              print("❌ JSON parsing error: $parseError");
              print("❌ Response was: ${response.data}");
            }
          }
        }
      } else {
        print("❌ Unexpected status code: ${response.statusCode}");
      }

      return null;
    } catch (e) {
      print("❌ Error in fetching user in Service: $e");
      if (e is DioException) {
        print("❌ Dio error details:");
        print("   Status code: ${e.response?.statusCode}");
        print("   Response data: ${e.response?.data}");
        print("   Error type: ${e.type}");
        print("   Error message: ${e.message}");
      }
      return null;
    }
  }

  // NEW METHOD: Get client ID by email using dedicated endpoint
  Future<int?> getClientIdByEmail(String email) async {
    try {
      print("🔍 Fetching client ID for email: $email");

      // Use the new dedicated endpoint (without /api since DioClient already includes it)
      Response response = await dio.get("/test/client-by-email/$email");

      print("🔍 Client by email response status: ${response.statusCode}");
      print("🔍 Client by email response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          int? clientId = response.data['clientId'];
          if (clientId != null) {
            print("✅ Successfully found client ID: $clientId for email: $email");
            return clientId;
          }
        }
      } else {
        print("❌ Unexpected status code when fetching client by email: ${response.statusCode}");
      }

      return null;
    } catch (e) {
      print("❌ Error in fetching client by email: $e");
      if (e is DioException) {
        print("❌ Dio client by email error details:");
        print("   Status code: ${e.response?.statusCode}");
        print("   Response data: ${e.response?.data}");
        print("   Error type: ${e.type}");
        print("   Error message: ${e.message}");
      }
      return null;
    }
  }

  // Fixed setClientFCM method with proper JSON format
  Future<bool> setClientFCM(int id, String token) async {
    try {
      print("🔔 Adding FCM token to client $id");
      print("🔔 Using endpoint: ${EndPoints.setFcmToken}/$id");
      print("🔔 Token: ${token.substring(0, 20)}...");

      // Send token as JSON object, not as raw string
      Response response = await dio.post(
          "${EndPoints.setFcmToken}/$id",
          data: {"token": token} // Changed: wrap token in JSON object
      );

      print("🔔 FCM assignment response status: ${response.statusCode}");
      print("🔔 FCM assignment response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ FCM token assigned successfully to client $id");
        return true;
      } else {
        print("❌ Error in assigning token to client: ${response.statusCode}");
        print("❌ Response: ${response.data}");
        return false;
      }
    } catch (e) {
      print("❌ Error in assigning token in Service: $e");
      if (e is DioException) {
        print("❌ Dio FCM error details:");
        print("   Status code: ${e.response?.statusCode}");
        print("   Response data: ${e.response?.data}");
        print("   Error type: ${e.type}");
        print("   Error message: ${e.message}");
      }
      return false;
    }
  }
}