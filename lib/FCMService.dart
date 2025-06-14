// Enhanced FCM Service with RendezVous notification handling - Fixed
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/FcmApiService.dart';
import 'dart:convert';

import 'package:pfe_banking_system/screens/NotificationsModel.dart';
import 'package:pfe_banking_system/screens/NotificationsService.dart';

class FCMService {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();
  static String? _currentToken;
  static GlobalKey<NavigatorState>? _navigatorKey;

  // Initialize FCM with enhanced debugging
  static Future<void> initialize({GlobalKey<NavigatorState>? navigatorKey}) async {
    _navigatorKey = navigatorKey;
    print("🔄 Starting FCM initialization...");

    try {
      // Request permission
      NotificationSettings settings = await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      print('📱 Notification permission status: ${settings.authorizationStatus}');

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {

        print('✅ User granted permission');

        // Initialize local notifications
        await _initializeLocalNotifications();

        // Get and send token to backend
        await _getAndSendToken();

        // Set up message handlers with debugging
        _setupMessageHandlers();

        print('✅ FCM Service initialized successfully');
      } else {
        print('❌ User declined permission: ${settings.authorizationStatus}');
      }
    } catch (e) {
      print('❌ FCM initialization error: $e');
      rethrow;
    }
  }

  static void _setupMessageHandlers() {
    print("🔧 Setting up FCM message handlers...");

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📨 FOREGROUND MESSAGE RECEIVED');
      print('Message ID: ${message.messageId}');
      print('From: ${message.from}');
      print('Data: ${message.data}');
      print('Notification Title: ${message.notification?.title}');
      print('Notification Body: ${message.notification?.body}');
      print('================================');

      _handleForegroundMessage(message);
    });

    // Handle background message taps
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📱 BACKGROUND MESSAGE TAPPED');
      print('Message ID: ${message.messageId}');
      print('Data: ${message.data}');
      print('================================');

      _handleBackgroundMessageTap(message);
    });

    // Handle token refresh
    _firebaseMessaging.onTokenRefresh.listen((String token) {
      print('🔄 FCM Token refreshed: ${token.substring(0, 20)}...');
      _currentToken = token;
      _sendTokenToBackend(token);
    });

    print("✅ Message handlers set up successfully");
  }

  static Future<void> _initializeLocalNotifications() async {
    print("🔔 Initializing local notifications...");

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        print('🔔 Local notification tapped: ${response.payload}');
        if (response.payload != null && response.payload!.isNotEmpty) {
          try {
            final data = json.decode(response.payload!);
            _handleNotificationTap(data);
          } catch (e) {
            print('❌ Error parsing notification payload: $e');
          }
        }
      },
    );

    await _createNotificationChannels();
    print("✅ Local notifications initialized");
  }

  static Future<void> _createNotificationChannels() async {
    final androidFlutterLocalNotificationsPlugin =
    _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

    if (androidFlutterLocalNotificationsPlugin != null) {
      // Banking operations channel
      const AndroidNotificationChannel bankingChannel = AndroidNotificationChannel(
        'banking_operations',
        'Banking Operations',
        description: 'Notifications for deposits, withdrawals, and transfers',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
        showBadge: true,
      );

      // Appointments channel
      const AndroidNotificationChannel appointmentsChannel = AndroidNotificationChannel(
        'appointments',
        'Appointments',
        description: 'Notifications for appointment confirmations and updates',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
        showBadge: true,
      );

      await androidFlutterLocalNotificationsPlugin.createNotificationChannel(bankingChannel);
      await androidFlutterLocalNotificationsPlugin.createNotificationChannel(appointmentsChannel);
      print("✅ Notification channels created");
    }
  }

  static Future<void> _getAndSendToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        _currentToken = token;
        print('🔑 FCM Token obtained: ${token.substring(0, 50)}...');
        await _sendTokenToBackend(token);
      } else {
        print('❌ Failed to get FCM token');
      }
    } catch (e) {
      print('❌ Error getting FCM token: $e');
    }
  }

  static Future<void> _sendTokenToBackend(String token) async {
    try {
      print('📤 Sending FCM token to backend...');
      final fcmApiService = FCMApiService();
      final result = await fcmApiService.updateFCMToken(token);

      if (result != null) {
        print('✅ FCM token sent to backend successfully');
      } else {
        print('❌ Failed to send FCM token to backend');
      }
    } catch (e) {
      print('❌ Error sending FCM token to backend: $e');
    }
  }

  // FIXED: Single definition of _handleForegroundMessage with notification storage
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print('🔄 Processing foreground message...');

    // Save notification to local storage FIRST
    await _saveNotificationToStorage(message);

    // Determine message type and show appropriate snackbar
    String messageType = message.data['type'] ?? 'UNKNOWN';
    String snackBarMessage = _getSnackBarMessage(messageType, message);

    _showSnackBarSafely(snackBarMessage);

    // Show local notification based on type
    await _showNotificationByType(message);
  }

  // FIXED: Single definition of _handleBackgroundMessageTap with notification storage
  static void _handleBackgroundMessageTap(RemoteMessage message) {
    print('📱 Handling background message tap...');

    // Save notification to local storage FIRST
    _saveNotificationToStorage(message);

    // Handle the tap
    _handleNotificationTap(message.data);
  }

  // Helper method to save notifications to storage
  static Future<void> _saveNotificationToStorage(RemoteMessage message) async {
    try {
      final notification = NotificationModel.fromFirebaseMessage(message);
      await NotificationStorageService.saveNotification(notification);
      print('📱 Notification saved to local storage');
    } catch (e) {
      print('❌ Error saving notification to storage: $e');
    }
  }

  static String _getSnackBarMessage(String messageType, RemoteMessage message) {
    switch (messageType.toUpperCase()) {
      case 'APPOINTMENT_CONFIRMED':
        return 'Appointment Confirmed: ${message.notification?.title ?? ""}';
      case 'DEPOSIT':
        return 'Deposit Received: ${message.notification?.title ?? ""}';
      case 'WITHDRAWAL':
        return 'Withdrawal Processed: ${message.notification?.title ?? ""}';
      case 'TRANSFER_RECEIVED':
        return 'Transfer Received: ${message.notification?.title ?? ""}';
      case 'TRANSFER_SENT':
        return 'Transfer Sent: ${message.notification?.title ?? ""}';
      default:
        return 'New Notification: ${message.notification?.title ?? "Banking Update"}';
    }
  }

  static void _showSnackBarSafely(String message) {
    try {
      if (_navigatorKey?.currentContext != null) {
        final context = _navigatorKey!.currentContext!;
        final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
        if (scaffoldMessenger != null) {
          scaffoldMessenger.showSnackBar(
            SnackBar(
              content: Text(message),
              duration: const Duration(seconds: 4),
              backgroundColor: Colors.blue.shade600,
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'View',
                textColor: Colors.white,
                onPressed: () {
                  // Handle view action if needed
                },
              ),
            ),
          );
        } else {
          print('📱 No ScaffoldMessenger available, skipping SnackBar');
        }
      } else {
        print('📱 No context available, skipping SnackBar');
      }
    } catch (e) {
      print('❌ Error showing SnackBar: $e');
    }
  }

  static Future<void> _showNotificationByType(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification == null) return;

    String messageType = message.data['type'] ?? 'UNKNOWN';

    // Determine channel and icon based on message type
    String channelId = 'banking_operations';
    String channelName = 'Banking Operations';
    Color notificationColor = Colors.blue;

    switch (messageType.toUpperCase()) {
      case 'APPOINTMENT_CONFIRMED':
        channelId = 'appointments';
        channelName = 'Appointments';
        notificationColor = Colors.green;
        break;
      case 'DEPOSIT':
        notificationColor = Colors.green;
        break;
      case 'WITHDRAWAL':
        notificationColor = Colors.orange;
        break;
      case 'TRANSFER_RECEIVED':
        notificationColor = Colors.blue;
        break;
      case 'TRANSFER_SENT':
        notificationColor = Colors.purple;
        break;
    }

    print('🔔 Showing $messageType notification...');

    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: 'Banking and appointment notifications',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      color: notificationColor,
      styleInformation: BigTextStyleInformation(
        _getExpandedContent(messageType, message.data),
      ),
      autoCancel: true,
      enableVibration: true,
      playSound: true,
      ticker: notification.title,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        subtitle: 'Banking Notification',
      ),
    );

    int notificationId = DateTime.now().millisecondsSinceEpoch.remainder(100000);

    await _localNotifications.show(
      notificationId,
      notification.title,
      notification.body,
      notificationDetails,
      payload: json.encode(message.data),
    );

    print('✅ $messageType notification shown with ID: $notificationId');
  }

  static String _getExpandedContent(String messageType, Map<String, dynamic> data) {
    switch (messageType.toUpperCase()) {
      case 'APPOINTMENT_CONFIRMED':
        String content = 'Your appointment has been confirmed.';
        if (data['date'] != null && data['time'] != null) {
          content += '\nDate: ${data['date']} at ${data['time']}';
        }
        if (data['agencyCity'] != null) {
          content += '\nLocation: ${data['agencyCity']} Branch';
        }
        if (data['subject'] != null && data['subject'].toString().isNotEmpty) {
          content += '\nSubject: ${data['subject']}';
        }
        return content;

      case 'DEPOSIT':
        String content = 'Deposit received successfully.';
        if (data['amount'] != null) {
          content += '\nAmount: ${data['amount']} TND';
        }
        return content;

      case 'WITHDRAWAL':
        String content = 'Withdrawal processed successfully.';
        if (data['amount'] != null) {
          content += '\nAmount: ${data['amount']} TND';
        }
        return content;

      case 'TRANSFER_RECEIVED':
        String content = 'Transfer received.';
        if (data['amount'] != null) {
          content += '\nAmount: ${data['amount']} TND';
        }
        if (data['senderName'] != null) {
          content += '\nFrom: ${data['senderName']}';
        }
        return content;

      case 'TRANSFER_SENT':
        String content = 'Transfer sent successfully.';
        if (data['amount'] != null) {
          content += '\nAmount: ${data['amount']} TND';
        }
        if (data['receiverName'] != null) {
          content += '\nTo: ${data['receiverName']}';
        }
        return content;

      default:
        return 'Check your banking app for more details.';
    }
  }

  static void _handleNotificationTap(Map<String, dynamic> data) {
    print('👆 Notification tapped with data: $data');

    String? notificationType = data['type'];
    String? operationId = data['operationId'] ?? data['appointmentId'];
    String? amount = data['amount'];

    print('Notification details:');
    print('- Type: $notificationType');
    print('- Operation/Appointment ID: $operationId');
    print('- Amount: $amount');

    // Show a dialog for debugging
    _showDialogSafely(notificationType, operationId, amount, data);

    // Add your navigation logic here based on notification type
    switch (notificationType?.toUpperCase()) {
      case 'APPOINTMENT_CONFIRMED':
        print('📅 Navigate to appointment details');
        // Navigate to appointment details screen
        break;
      case 'DEPOSIT':
        print('🏦 Navigate to deposit details');
        // Navigate to transaction history or deposit details
        break;
      case 'WITHDRAWAL':
        print('💰 Navigate to withdrawal details');
        // Navigate to transaction history or withdrawal details
        break;
      case 'TRANSFER_RECEIVED':
        print('📥 Navigate to transfer received details');
        // Navigate to transfer details
        break;
      case 'TRANSFER_SENT':
        print('📤 Navigate to transfer sent details');
        // Navigate to transfer details
        break;
      default:
        print('🏠 Navigate to home');
    // Navigate to home screen
    }
  }

  static void _showDialogSafely(String? notificationType, String? operationId, String? amount, Map<String, dynamic> data) {
    try {
      if (_navigatorKey?.currentContext != null) {
        final context = _navigatorKey!.currentContext!;

        List<Widget> contentWidgets = [
          Text('Type: $notificationType', style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
        ];

        if (operationId != null) {
          contentWidgets.add(Text('ID: $operationId'));
          contentWidgets.add(const SizedBox(height: 4));
        }

        if (amount != null) {
          contentWidgets.add(Text('Amount: $amount TND', style: const TextStyle(color: Colors.green)));
          contentWidgets.add(const SizedBox(height: 4));
        }

        // Add appointment-specific details
        if (notificationType?.toUpperCase() == 'APPOINTMENT_CONFIRMED') {
          if (data['date'] != null) {
            contentWidgets.add(Text('Date: ${data['date']}'));
          }
          if (data['time'] != null) {
            contentWidgets.add(Text('Time: ${data['time']}'));
          }
          if (data['agencyCity'] != null) {
            contentWidgets.add(Text('Location: ${data['agencyCity']} Branch'));
          }
          if (data['subject'] != null && data['subject'].toString().isNotEmpty) {
            contentWidgets.add(Text('Subject: ${data['subject']}'));
          }
        }

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                Icon(
                  notificationType?.toUpperCase() == 'APPOINTMENT_CONFIRMED'
                      ? Icons.calendar_today
                      : Icons.account_balance,
                  color: Colors.blue,
                ),
                const SizedBox(width: 8),
                const Text('Notification Details'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: contentWidgets,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Close'),
              ),
              if (notificationType?.toUpperCase() == 'APPOINTMENT_CONFIRMED')
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to appointments screen
                  },
                  child: const Text('View Appointment'),
                ),
              if (notificationType?.toUpperCase() != 'APPOINTMENT_CONFIRMED')
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigate to transaction details
                  },
                  child: const Text('View Details'),
                ),
            ],
          ),
        );
      } else {
        print('📱 No context available for dialog');
      }
    } catch (e) {
      print('❌ Error showing dialog: $e');
    }
  }

  // Handle initial message when app starts from notification
  static Future<void> handleInitialMessage() async {
    try {
      RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        print('📱 App opened from notification');
        await _saveNotificationToStorage(initialMessage);
        _handleNotificationTap(initialMessage.data);
      }
    } catch (e) {
      print('❌ Error handling initial message: $e');
    }
  }

  // Test method to show a notification immediately
  static Future<void> showTestNotification() async {
    print('🧪 Showing test notification...');

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'banking_operations',
      'Banking Operations',
      channelDescription: 'Test notification',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _localNotifications.show(
      0,
      'Test Banking Notification',
      'This is a test to verify notifications are working',
      notificationDetails,
    );

    print('✅ Test notification shown');
  }

  // Get current token for debugging
  static String? getCurrentToken() {
    if (_currentToken != null) {
      print('🔑 Current FCM Token: ${_currentToken!.substring(0, 20)}...');
    }
    return _currentToken;
  }

  // Method to force refresh token
  static Future<String?> refreshToken() async {
    try {
      print('🔄 Refreshing FCM token...');
      await _firebaseMessaging.deleteToken();
      String? newToken = await _firebaseMessaging.getToken();
      if (newToken != null) {
        _currentToken = newToken;
        await _sendTokenToBackend(newToken);
        print('✅ FCM token refreshed successfully');
        print('🔑 New token: ${newToken.substring(0, 20)}...');
      }
      return newToken;
    } catch (e) {
      print('❌ Error refreshing FCM token: $e');
      return null;
    }
  }
}