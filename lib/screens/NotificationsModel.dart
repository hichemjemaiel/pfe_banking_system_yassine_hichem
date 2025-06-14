// File: screens/NotificationsModel.dart
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String type;
  final DateTime timestamp;
  final Map<String, dynamic> data;
  final bool isRead;
  final String? amount;
  final String? operationId;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.timestamp,
    required this.data,
    this.isRead = false,
    this.amount,
    this.operationId,
  });

  factory NotificationModel.fromFirebaseMessage(RemoteMessage message) {
    return NotificationModel(
      id: message.messageId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: message.notification?.title ?? '',
      body: message.notification?.body ?? '',
      type: message.data['type'] ?? 'UNKNOWN',
      timestamp: DateTime.now(),
      data: message.data,
      amount: message.data['amount'],
      operationId: message.data['operationId'] ?? message.data['appointmentId'],
    );
  }

  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      body: body,
      type: type,
      timestamp: timestamp,
      data: data,
      isRead: isRead ?? this.isRead,
      amount: amount,
      operationId: operationId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type,
      'timestamp': timestamp.toIso8601String(),
      'data': data,
      'isRead': isRead,
      'amount': amount,
      'operationId': operationId,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      timestamp: DateTime.parse(json['timestamp']),
      data: Map<String, dynamic>.from(json['data']),
      isRead: json['isRead'] ?? false,
      amount: json['amount'],
      operationId: json['operationId'],
    );
  }
}