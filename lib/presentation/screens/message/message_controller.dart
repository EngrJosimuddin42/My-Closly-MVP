import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatUser {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final bool isActive;
  final Color avatarColor;

  const ChatUser({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.isActive = false,
    required this.avatarColor,
  });
}

class ChatMessage {
  final String id;
  final String text;
  final String time;
  final bool isMe;
  final ProductCard? product;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.time,
    required this.isMe,
    this.product,
  });
}

class ProductCard {
  final String name;
  final String brand;
  final String price;
  final int matchPercent;

  const ProductCard({
    required this.name,
    required this.brand,
    required this.price,
    required this.matchPercent,
  });
}

class MessageController extends GetxController {
  final searchController = TextEditingController();
  final messageController = TextEditingController();

  // Active users
  final activeUsers = const [
    ChatUser(id: '1', name: 'Emma',  lastMessage: '', time: '', isActive: true,  avatarColor: Color(0xFFD4856A)),
    ChatUser(id: '2', name: 'Julia', lastMessage: '', time: '', isActive: true,  avatarColor: Color(0xFF8A9BAA)),
    ChatUser(id: '3', name: 'Sofia', lastMessage: '', time: '', isActive: true,  avatarColor: Color(0xFF6A7A8A)),
    ChatUser(id: '4', name: 'Lisa',  lastMessage: '', time: '', isActive: true,  avatarColor: Color(0xFFD4956A)),
    ChatUser(id: '5', name: 'Alex',  lastMessage: '', time: '', isActive: false, avatarColor: Color(0xFF8A6A5A)),
  ];

  // Conversation list
  final conversations = const [
    ChatUser(id: '1', name: 'Emma Wilson',    lastMessage: 'Check this blazer I found!', time: '2m',       isActive: true,  avatarColor: Color(0xFFD4856A)),
    ChatUser(id: '2', name: 'Alex Parker',    lastMessage: 'This outfit is amazing',      time: '1h',       isActive: false, avatarColor: Color(0xFF4A3A32)),
    ChatUser(id: '3', name: 'Lisa Smith',     lastMessage: 'Where did you buy this?',     time: 'Yesterday',isActive: true,  avatarColor: Color(0xFF8A6A5A)),
    ChatUser(id: '4', name: 'Sofia Martinez', lastMessage: 'Love your style!',            time: '2d ago',   isActive: true,  avatarColor: Color(0xFFD4A87A)),
    ChatUser(id: '5', name: 'Julia Chen',     lastMessage: 'Thanks for the recommendation!', time: '1w ago',isActive: false, avatarColor: Color(0xFF6A8A7A)),
  ];

  // Selected chat user
  final selectedUser = Rxn<ChatUser>();

  // Chat messages for Emma Wilson
  final messages = <ChatMessage>[
    ChatMessage(
      id: '1',
      text: "Hey! Did you see this amazing blazer?",
      time: '10:32 AM',
      isMe: false,
      product: ProductCard(
        name: 'Oversized Linen Blazer',
        brand: 'COS, Spring 2025',
        price: '€ 98',
        matchPercent: 96,
      ),
    ),
    ChatMessage(
      id: '2',
      text: 'That jacket looks amazing! 😍',
      time: '10:34 AM',
      isMe: true,
    ),
  ].obs;

  void openChat(ChatUser user) {
    selectedUser.value = user;
  }

  void closeChat() {
    selectedUser.value = null;
  }

  void onAddToCloset() => Get.snackbar('Added!', 'Item added to closet',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF2C1810),
      colorText: Colors.white);

  void onWhereToBuy() => Get.snackbar('Where to Buy', 'Opening store finder...',
      snackPosition: SnackPosition.TOP);

  void onSimilarStyles() => Get.snackbar('Similar Styles', 'Loading similar items...',
      snackPosition: SnackPosition.TOP);

  void onSendMessage() {
    if (messageController.text.trim().isEmpty) return;
    final text = messageController.text.trim();
    messageController.clear();
    messages.add(ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      time: _currentTime(),
      isMe: true,
    ));
  }

  String _currentTime() {
    final now = DateTime.now();
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  @override
  void onClose() {
    searchController.dispose();
    messageController.dispose();
    super.onClose();
  }
}