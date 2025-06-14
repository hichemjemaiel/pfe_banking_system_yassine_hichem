import 'package:dio/dio.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';

import '../model/ChatRequest.dart';
import '../model/ChatResponse.dart';


class ApiService {

   final Dio dio = DioClient().dio;


  Future<ChatResponse> sendMessage({
    required String userId,
    required String message,
  }) async {
    try {
      final response = await dio.post(
        '${EndPoints.chatbot}/${userId}',
        data: ChatRequest(message: message).toJson(),
      );

      if (response.statusCode == 200) {
        return ChatResponse.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to send message',
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        return ChatResponse(
          success: false,
          message: 'Invalid request. Please check your input.',
          errorCode: 'BAD_REQUEST',
        );
      } else if (e.response?.statusCode == 500) {
        return ChatResponse(
          success: false,
          message: 'Server error. Please try again later.',
          errorCode: 'SERVER_ERROR',
        );
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return ChatResponse(
          success: false,
          message: 'Connection timeout. Please check your internet connection.',
          errorCode: 'TIMEOUT',
        );
      } else {
        return ChatResponse(
          success: false,
          message: 'Network error. Please try again.',
          errorCode: 'NETWORK_ERROR',
        );
      }
    } catch (e) {
      return ChatResponse(
        success: false,
        message: 'Unexpected error occurred. Please try again.',
        errorCode: 'UNKNOWN_ERROR',
      );
    }
  }

  // Health check method
  Future<bool> checkHealth() async {
    try {
      final response = await dio.get('/api/health');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}