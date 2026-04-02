import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum NotifType { like, follow, comment, points, repost }

class NotifItem {
  final String id;
  final NotifType type;
  final String userName;
  final String message;
  final String time;
  final Color avatarColor;
  final bool hasImage;       // right-side thumbnail
  final bool hasPoints;
  final int points;
  bool isRead;

  NotifItem({
    required this.id,
    required this.type,
    required this.userName,
    required this.message,
    required this.time,
    required this.avatarColor,
    this.hasImage = false,
    this.hasPoints = false,
    this.points = 0,
    this.isRead = false,
  });
}

class NotificationsController extends GetxController {
  final notifications = <NotifItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadNotifications();
  }

  void _loadNotifications() {
    notifications.value = [
      NotifItem(
        id: '1',
        type: NotifType.like,
        userName: 'Emma Watson',
        message: 'Emma Watson liked your look',
        time: '2m ago',
        avatarColor: const Color(0xFFD4856A),
        hasImage: true,
        hasPoints: true,
        points: 5,
      ),
      NotifItem(
        id: '2',
        type: NotifType.follow,
        userName: 'Sophie Anderson',
        message: 'Sophie Anderson started following you',
        time: '15m ago',
        avatarColor: const Color(0xFF6A7A8A),
        hasImage: false,
      ),
      NotifItem(
        id: '3',
        type: NotifType.comment,
        userName: 'Olivia Brown',
        message: 'Olivia Brown commented: "Love this outfit! Where did you get those shoes?"',
        time: '1h ago',
        avatarColor: const Color(0xFF8A6A5A),
        hasImage: true,
      ),
      NotifItem(
        id: '4',
        type: NotifType.points,
        userName: '',
        message: 'You earned 120 Closet Points for sharing a new post!',
        time: '2h ago',
        avatarColor: const Color(0xFFD4E8F0),
        hasImage: false,
        hasPoints: true,
        points: 120,
      ),
      NotifItem(
        id: '5',
        type: NotifType.repost,
        userName: 'Mia Johnson',
        message: 'Mia Johnson also repost your reposted post.',
        time: '3h ago',
        avatarColor: const Color(0xFF4A3A32),
        hasImage: true,
      ),
    ];
  }

  int get newCount => notifications.where((n) => !n.isRead).length;

  void markAllRead() {
    for (final n in notifications) {
      n.isRead = true;
    }
    notifications.refresh();
  }

  void markRead(String id) {
    final notif = notifications.firstWhereOrNull((n) => n.id == id);
    if (notif != null) {
      notif.isRead = true;
      notifications.refresh();
    }
  }
}