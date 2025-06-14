import 'dart:convert';
import 'package:http/http.dart' as http;

class FCMApiService {
  static const String baseUrl = 'http://your-server-url:8080'; // Replace with your actual server URL

  // Update FCM token for authenticated user
  Future<Map<String, dynamic>?> updateFCMToken(String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/client/fcm-token'),
        headers: {
          'Content-Type': 'application/json',
          // Add your authentication headers here
          // 'Authorization': 'Bearer $yourJwtToken',
        },
        body: json.encode({'token': token}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to update FCM token: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error updating FCM token: $e');
      return null;
    }
  }

  // Test direct notification sending
  Future<Map<String, dynamic>?> testSendNotification({
    required String token,
    required String title,
    required String body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/test/send-notification'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'token': token,
          'title': title,
          'body': body,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to send test notification: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error sending test notification: $e');
      return null;
    }
  }

  // Test deposit with notification
  Future<Map<String, dynamic>?> testDepositWithNotification({
    required int accountId,
    required double amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/test/create-deposit-with-notification'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'accountId': accountId,
          'amount': amount,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to create deposit: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error creating deposit: $e');
      return null;
    }
  }

  // Test withdrawal with notification
  Future<Map<String, dynamic>?> testWithdrawalWithNotification({
    required int accountId,
    required double amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/test/create-withdrawal-with-notification'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'accountId': accountId,
          'amount': amount,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to create withdrawal: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error creating withdrawal: $e');
      return null;
    }
  }

  // Test transfer with notification
  Future<Map<String, dynamic>?> testTransferWithNotification({
    required String senderRIB,
    required String receiverRIB,
    required double amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/test/create-transfer-with-notification'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'senderRIB': senderRIB,
          'receiverRIB': receiverRIB,
          'amount': amount,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to create transfer: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error creating transfer: $e');
      return null;
    }
  }

  // Get all banking accounts
  Future<List<Map<String, dynamic>>?> getBankingAccounts() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/test/accounts'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> accounts = json.decode(response.body);
        return accounts.cast<Map<String, dynamic>>();
      } else {
        print('Failed to get accounts: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting accounts: $e');
      return null;
    }
  }

  // Get all clients
  Future<List<Map<String, dynamic>>?> getClients() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/test/clients'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> clients = json.decode(response.body);
        return clients.cast<Map<String, dynamic>>();
      } else {
        print('Failed to get clients: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting clients: $e');
      return null;
    }
  }

  // Set FCM token for specific client (for testing)
  Future<Map<String, dynamic>?> setClientFCMToken({
    required int clientId,
    required String token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/test/set-fcm-token/$clientId'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'token': token}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to set FCM token: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error setting FCM token: $e');
      return null;
    }
  }
}