// File: screens/NotificationsService.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'NotificationsModel.dart';

class NotificationStorageService {
  static const String _key = 'app_notifications';
  static const int _maxNotifications = 100;

  static Future<void> saveNotification(NotificationModel notification) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<NotificationModel> notifications = await getNotifications();

      // Check if notification already exists (avoid duplicates)
      bool alreadyExists = notifications.any((n) => n.id == notification.id);
      if (alreadyExists) {
        print('📱 Notification already exists, skipping: ${notification.id}');
        return;
      }

      // Add new notification at the beginning
      notifications.insert(0, notification);

      // Keep only the latest notifications
      if (notifications.length > _maxNotifications) {
        notifications = notifications.take(_maxNotifications).toList();
      }

      // Convert to JSON and save
      final jsonList = notifications.map((n) => n.toJson()).toList();
      await prefs.setString(_key, json.encode(jsonList));

      print('✅ Notification saved to storage: ${notification.title}');
    } catch (e) {
      print('❌ Error saving notification: $e');
    }
  }

  static Future<List<NotificationModel>> getNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_key);

      if (jsonString == null) return [];

      final jsonList = json.decode(jsonString) as List;
      return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
    } catch (e) {
      print('❌ Error loading notifications: $e');
      return [];
    }
  }

  static Future<void> markAsRead(String notificationId) async {
    try {
      List<NotificationModel> notifications = await getNotifications();

      final updatedNotifications = notifications.map((notification) {
        if (notification.id == notificationId) {
          return notification.copyWith(isRead: true);
        }
        return notification;
      }).toList();

      final prefs = await SharedPreferences.getInstance();
      final jsonList = updatedNotifications.map((n) => n.toJson()).toList();
      await prefs.setString(_key, json.encode(jsonList));

      print('✅ Notification marked as read: $notificationId');
    } catch (e) {
      print('❌ Error marking notification as read: $e');
    }
  }

  static Future<void> clearAllNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_key);
      print('✅ All notifications cleared');
    } catch (e) {
      print('❌ Error clearing notifications: $e');
    }
  }

  static Future<int> getUnreadCount() async {
    try {
      List<NotificationModel> notifications = await getNotifications();
      return notifications.where((n) => !n.isRead).length;
    } catch (e) {
      print('❌ Error getting unread count: $e');
      return 0;
    }
  }

  static Future<void> markAllAsRead() async {
    try {
      List<NotificationModel> notifications = await getNotifications();

      final updatedNotifications = notifications.map((notification) {
        return notification.copyWith(isRead: true);
      }).toList();

      final prefs = await SharedPreferences.getInstance();
      final jsonList = updatedNotifications.map((n) => n.toJson()).toList();
      await prefs.setString(_key, json.encode(jsonList));

      print('✅ All notifications marked as read');
    } catch (e) {
      print('❌ Error marking all notifications as read: $e');
    }
  }
}

// Test helper class for adding sample notifications
class NotificationTestHelper {
  static Future<void> addTestNotification() async {
    final testNotification = NotificationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Dépôt Airtel Money',
      body: 'Dépôt de 20 000 XAF sur le compte\n000467882 via l\'agence Hyperion..',
      type: 'DEPOSIT',
      timestamp: DateTime.now(),
      data: {
        'type': 'DEPOSIT',
        'amount': '20000',
        'operationId': '12345',
      },
      amount: '20000',
      operationId: '12345',
    );

    await NotificationStorageService.saveNotification(testNotification);
    print('✅ Test notification added');
  }

  static Future<void> addMultipleTestNotifications() async {
    final notifications = [
      NotificationModel(
        id: '1',
        title: 'Dépôt Airtel Money',
        body: 'Dépôt de 20 000 XAF sur le compte\n000467882 via l\'agence Hyperion..',
        type: 'DEPOSIT',
        timestamp: DateTime.now().subtract(Duration(minutes: 30)),
        data: {'type': 'DEPOSIT', 'amount': '20000'},
        amount: '20000',
      ),
      NotificationModel(
        id: '2',
        title: 'Retrait Airtel Money',
        body: 'Retrait de 15 000 XAF du compte\n000467882 via l\'agence Central..',
        type: 'WITHDRAWAL',
        timestamp: DateTime.now().subtract(Duration(hours: 2)),
        data: {'type': 'WITHDRAWAL', 'amount': '15000'},
        amount: '15000',
      ),
      NotificationModel(
        id: '3',
        title: 'Virement reçu',
        body: 'Virement de 50 000 XAF reçu\nde John Doe..',
        type: 'TRANSFER_RECEIVED',
        timestamp: DateTime.now().subtract(Duration(days: 1)),
        data: {'type': 'TRANSFER_RECEIVED', 'amount': '50000'},
        amount: '50000',
      ),
      NotificationModel(
        id: '4',
        title: 'Rendez-vous confirmé',
        body: 'Votre rendez-vous du 08 juillet\na été confirmé à l\'agence Hyperion..',
        type: 'APPOINTMENT_CONFIRMED',
        timestamp: DateTime.now().subtract(Duration(days: 2)),
        data: {'type': 'APPOINTMENT_CONFIRMED'},
      ),
      NotificationModel(
        id: '5',
        title: 'Virement envoyé',
        body: 'Virement de 25 000 XAF envoyé\nvers Jane Smith..',
        type: 'TRANSFER_SENT',
        timestamp: DateTime.now().subtract(Duration(hours: 5)),
        data: {'type': 'TRANSFER_SENT', 'amount': '25000'},
        amount: '25000',
      ),
    ];

    for (final notification in notifications) {
      await NotificationStorageService.saveNotification(notification);
    }
    print('✅ Multiple test notifications added');
  }
}