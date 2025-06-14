// File: screens/NotificationBadge.dart or widgets/NotificationBadge.dart
import 'package:flutter/material.dart';
import 'NotificationsService.dart';

class NotificationBadge extends StatefulWidget {
  final Widget child;

  const NotificationBadge({Key? key, required this.child}) : super(key: key);

  @override
  _NotificationBadgeState createState() => _NotificationBadgeState();
}

class _NotificationBadgeState extends State<NotificationBadge> {
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _updateUnreadCount();

    // Optional: Set up a timer to refresh the count periodically
    _setupPeriodicRefresh();
  }

  Future<void> _updateUnreadCount() async {
    final count = await NotificationStorageService.getUnreadCount();
    if (mounted) {
      setState(() {
        unreadCount = count;
      });
    }
  }

  void _setupPeriodicRefresh() {
    // Refresh the count every 30 seconds when the widget is visible
    Future.delayed(Duration(seconds: 30), () {
      if (mounted) {
        _updateUnreadCount();
        _setupPeriodicRefresh();
      }
    });
  }

  // Public method to manually refresh the count
  void refresh() {
    _updateUnreadCount();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (unreadCount > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                unreadCount > 99 ? '99+' : unreadCount.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}

// Alternative simpler badge without state management
class SimpleNotificationBadge extends StatelessWidget {
  final Widget child;
  final int count;

  const SimpleNotificationBadge({
    Key? key,
    required this.child,
    required this.count
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (count > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: BoxConstraints(
                minWidth: 18,
                minHeight: 18,
              ),
              child: Text(
                count > 99 ? '99+' : count.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}