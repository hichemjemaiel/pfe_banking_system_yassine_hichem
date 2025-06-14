import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:pfe_banking_system/screens/authentication/model/LoginRequest.dart';
import 'package:pfe_banking_system/screens/authentication/model/RegisterRequest.dart';
import 'package:pfe_banking_system/screens/authentication/model/User.dart';
import 'package:pfe_banking_system/screens/authentication/service/ApiService.dart';
import '../../../FCMService.dart';

class AuthProvider extends ChangeNotifier{
  ApiService service = ApiService();
  bool isAuthenticated = false ;
  bool isLoading = false ;
  String? error;
  User? user;

  Future<void> checkAuthentication() async{
    final token = await service.getToken();
    isAuthenticated = token != null;
    notifyListeners();
  }

  Future<bool> register(RegisterRequest request)async{
    isLoading = true;
    error = null;
    notifyListeners();
    try{
      await service.register(request);
      isLoading = false;
      notifyListeners();
      return true;
    }catch(e){
      isLoading = false ;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<bool> setPassword(LoginRequest request) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      print('🔧 Setting password for email: ${request.email}');

      // Step 1: Set the password (works with User entity by email)
      await service.setPassword(request);
      print('✅ Password set successfully');

      // Step 2: Get the client ID by email (from Client entity)
      print('🔍 Getting client ID for FCM assignment...');
      int? clientId = await service.getClientIdByEmail(request.email);

      if (clientId != null) {
        print('✅ Found client ID: $clientId');

        // Step 3: Get FCM token
        print('🔔 Getting FCM token...');
        String? fcmToken = FCMService.getCurrentToken();

        if (fcmToken == null) {
          print('🔔 No current token, refreshing...');
          fcmToken = await FCMService.refreshToken();
        }

        if (fcmToken != null) {
          print('🔔 FCM token available: ${fcmToken.substring(0, 20)}...');

          // Step 4: Assign FCM token to client
          print('🔔 Assigning FCM token to client $clientId...');
          bool tokenAssigned = await service.setClientFCM(clientId, fcmToken);

          if (tokenAssigned) {
            print('✅ FCM token assigned successfully');
          } else {
            print('⚠️ Password set but FCM token assignment failed');
            // Don't fail the whole process if FCM fails
          }
        } else {
          print('⚠️ Could not get FCM token, proceeding without notifications');
        }
      } else {
        print('⚠️ Could not find client ID for email: ${request.email}');
        print('⚠️ This might mean the client doesn\'t exist in the banking system yet');
        // Still consider this a success since password was set
      }

      isLoading = false;
      notifyListeners();
      return true;

    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
      print('❌ Error in setPassword: $e');
      return false;
    }
  }

  Future<bool> login(LoginRequest request) async{
    isLoading = true;
    error = null;
    notifyListeners();
    try{
      await service.login(request);
      isAuthenticated = true;
      isLoading = false;
      notifyListeners();
      return true;
    }catch(e){
      isLoading  = false;
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  Future<void> logout()async{
    isLoading =true;
    notifyListeners();
    try{
      await service.logout();
      isAuthenticated = false;
    }catch(e){
      error = e.toString();
    }finally{
      isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    error = null;
    notifyListeners();
  }

  Future<void> resetPassword(LoginRequest request)async{
    try{
      print("Resetting password");
      final result = await service.resetPassword(request);
      if(result){
        print("Password reset successfully");
      }
    }catch(e){
      print("Error in resetting password provider");
    }
  }

  Future<User?> getUser(String email)async{
    try{
      user = await service.getUser(email);
      notifyListeners();
      return user;
    }catch(e){
      print("Error in finding User in Provider ${e}");
    }
  }

  Future<void> setClientFcm(String ClientId)async{
    try{
      int Id = int.parse(ClientId);
      String? fcmToken = FCMService.getCurrentToken();

      if(fcmToken == null){
        fcmToken = await FCMService.refreshToken();
      }
      if(fcmToken != null){
        final result = await service.setClientFCM(Id, fcmToken);
        if(result){
          print("fcm token added successfully to client");
        }
      }

    }catch(e){
      print("Error in Assiging token in Provider ${e}");
    }
  }
}