import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Bar.dart';
import 'package:intl/intl.dart';
import 'NotificationsModel.dart';
import 'NotificationsService.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  int myIndex = 3; // Set to 3 since notifications is usually the 4th tab
  List<NotificationModel> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() => isLoading = true);

    try {
      final loadedNotifications = await NotificationStorageService.getNotifications();
      setState(() {
        notifications = loadedNotifications;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading notifications: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _markAsRead(NotificationModel notification) async {
    if (!notification.isRead) {
      await NotificationStorageService.markAsRead(notification.id);
      await _loadNotifications(); // Refresh the list
    }
  }

  String _getNotificationTitle(NotificationModel notification) {
    if (notification.title.isNotEmpty) {
      return notification.title;
    }

    // Fallback based on type
    switch (notification.type.toUpperCase()) {
      case 'DEPOSIT':
        return 'Dépôt Airtel Money';
      case 'WITHDRAWAL':
        return 'Retrait Airtel Money';
      case 'TRANSFER_RECEIVED':
        return 'Virement reçu';
      case 'TRANSFER_SENT':
        return 'Virement envoyé';
      case 'APPOINTMENT_CONFIRMED':
        return 'Rendez-vous confirmé';
      default:
        return 'Notification bancaire';
    }
  }

  String _getNotificationBody(NotificationModel notification) {
    if (notification.body.isNotEmpty) {
      return notification.body;
    }

    // Create a body based on type and amount
    String amount = notification.amount ?? '0';
    switch (notification.type.toUpperCase()) {
      case 'DEPOSIT':
        return 'Dépôt de $amount XAF sur le compte\nvia l\'agence...';
      case 'WITHDRAWAL':
        return 'Retrait de $amount XAF du compte\nvia l\'agence...';
      case 'TRANSFER_RECEIVED':
        return 'Virement de $amount XAF reçu\nsur votre compte...';
      case 'TRANSFER_SENT':
        return 'Virement de $amount XAF envoyé\ndepuis votre compte...';
      case 'APPOINTMENT_CONFIRMED':
        return 'Votre rendez-vous a été confirmé\nConsultez les détails...';
      default:
        return 'Nouvelle notification\nConsultez votre application...';
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    // FIXED: Use simple DateFormat without locale to avoid initialization issues
    final DateFormat formatter = DateFormat('dd MMM yyyy | HH:mm');
    return formatter.format(timestamp);
  }

  String _getRelativeTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return 'Il y a ${difference.inDays} jour${difference.inDays > 1 ? 's' : ''}';
    } else if (difference.inHours > 0) {
      return 'Il y a ${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return 'Il y a ${difference.inMinutes}min';
    } else {
      return 'À l\'instant';
    }
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return GestureDetector(
      onTap: () => _markAsRead(notification),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          height: 90,
          width: 400,
          decoration: BoxDecoration(
            color: notification.isRead ? Color(0xFFF7F7F7) : Color(0xFFE3F2FD), // Slightly different color for unread
            borderRadius: BorderRadius.circular(20),
            border: notification.isRead ? null : Border.all(color: Colors.blue.withOpacity(0.3), width: 1),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Stack(
                  children: [
                    Image.asset("assets/bambo.png", scale: 1.5),
                    if (!notification.isRead)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _getNotificationTitle(notification),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: notification.isRead ? Colors.black : Colors.blue[800],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      _getNotificationBody(notification),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _formatTimestamp(notification.timestamp),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                        if (notification.amount != null)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '${notification.amount} XAF',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[700],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/bambo.png", scale: 1.0, opacity: AlwaysStoppedAnimation(0.3)),
          SizedBox(height: 20),
          Text(
            'Aucune notification',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Vous recevrez vos notifications ici',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Notifications"),
        centerTitle: true,
        actions: [
          if (notifications.isNotEmpty)
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'clear_all') {
                  await NotificationStorageService.clearAllNotifications();
                  await _loadNotifications();
                } else if (value == 'mark_all_read') {
                  await NotificationStorageService.markAllAsRead();
                  await _loadNotifications();
                } else if (value == 'add_test') {
                  await NotificationTestHelper.addMultipleTestNotifications();
                  await _loadNotifications();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'mark_all_read',
                  child: Row(
                    children: [
                      Icon(Icons.done_all, size: 20),
                      SizedBox(width: 8),
                      Text('Marquer tout lu'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'add_test',
                  child: Row(
                    children: [
                      Icon(Icons.add, size: 20),
                      SizedBox(width: 8),
                      Text('Test notifications'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'clear_all',
                  child: Row(
                    children: [
                      Icon(Icons.clear_all, size: 20),
                      SizedBox(width: 8),
                      Text('Effacer tout'),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      backgroundColor: Color(0xFFF2F2F2),
      bottomNavigationBar: Bar(
        myIndex: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
      ),
      body: RefreshIndicator(
        onRefresh: _loadNotifications,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 200,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: isLoading
                  ? Container(
                height: MediaQuery.of(context).size.height - 200,
                child: Center(child: CircularProgressIndicator()),
              )
                  : notifications.isEmpty
                  ? Container(
                height: MediaQuery.of(context).size.height - 200,
                child: _buildEmptyState(),
              )
                  : Column(
                children: [
                  SizedBox(height: 20),
                  ...notifications.map((notification) => _buildNotificationItem(notification)).toList(),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}