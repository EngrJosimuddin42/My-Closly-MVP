import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PointsTab { waysToEarn, rewards, activity }

class ClosetPointsController extends GetxController {
  final currentTab = PointsTab.waysToEarn.obs;
  final totalPoints = 1847.obs;
  final tier = 'GOLD'.obs;
  final monthlyPoints = 375.obs;
  final pointsToNext = 153.obs;
  final nextTier = 'Platinum'.obs;
  final maxTierPoints = 2000.obs;

  final waysToEarn = [
    {'icon': Icons.grid_view_outlined, 'title': 'Share a Look', 'desc': 'Repost your outfit to the feed', 'pts': '+120'},
    {'icon': Icons.person_add_outlined, 'title': 'Invite Friends', 'desc': 'Invite friends to join myClosly', 'pts': '+200'},
    {'icon': Icons.shopping_bag_outlined, 'title': 'Make a Purchase', 'desc': 'Earn 10% back on all purchases', 'pts': '+200'},
    {'icon': Icons.add_box_outlined, 'title': 'Add to Closet', 'desc': 'Log new pieces to your wardrobe', 'pts': '+50'},
  ];

  final rewards = [
    {'tier': 'BRONZE', 'title': '€5 Shopping Voucher', 'pts': 250, 'canAfford': true},
    {'tier': 'BRONZE', 'title': '€10 Shopping Voucher', 'pts': 500, 'canAfford': true},
    {'tier': 'SILVER', 'title': 'Free Shipping', 'pts': 750, 'canAfford': true},
    {'tier': 'SILVER', 'title': '€25 Shopping Voucher', 'pts': 1000, 'canAfford': true},
    {'tier': 'GOLD', 'title': '€50 Shopping Voucher', 'pts': 1500, 'canAfford': true},
    {'tier': 'GOLD', 'title': 'VIP Early Access', 'pts': 2000, 'canAfford': false},
  ];

  final activity = [
    {'icon': Icons.grid_view_outlined, 'title': 'Shared a Look', 'detail': 'Tuesday Outfit · COS Blazer', 'time': 'Today, 09:14', 'pts': '+120', 'positive': true, 'color': 0xFF4A90D9},
    {'icon': Icons.add_box_outlined, 'title': 'Added to Closet', 'detail': 'Linen Blazer · COS', 'time': 'Yesterday, 18:30', 'pts': '+50', 'positive': true, 'color': 0xFF4A90D9},
    {'icon': Icons.favorite_outline, 'title': 'Liked & Saved', 'detail': '5 items from the feed', 'time': '19 Mar, 14:22', 'pts': '+25', 'positive': true, 'color': 0xFF4A90D9},
    {'icon': Icons.label_outline, 'title': 'Redeemed Reward', 'detail': '€5 Shopping Voucher', 'time': '15 Mar, 11:05', 'pts': '-250', 'positive': false, 'color': 0xFFE8A020},
  ];

  void setTab(PointsTab tab) => currentTab.value = tab;

  void onRedeem(Map reward) {
    Get.snackbar(
      'Redeemed!',
      '${reward['title']} redeemed successfully.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF2C1810),
      colorText: Colors.white,
    );
  }

  double get progressValue => totalPoints.value / maxTierPoints.value;
}