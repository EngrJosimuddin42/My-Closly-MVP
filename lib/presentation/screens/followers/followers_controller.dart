import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum FollowerFilter { all, dnaMatch, newFollowers, location }

class FollowerUser {
  final String name;
  final String location;
  final int followers;
  final int dnaMatch;
  final String styleTag;
  final bool isFollowing;

  FollowerUser({
    required this.name,
    required this.location,
    required this.followers,
    required this.dnaMatch,
    required this.styleTag,
    this.isFollowing = false,
  });
}

class FollowersController extends GetxController {
  final searchController = TextEditingController();
  final selectedFilter = FollowerFilter.all.obs;
  final followingStates = <String, bool>{}.obs;

  final totalFollowers = 1247.obs;

  final suggested = [
    FollowerUser(name: 'Emma Wilson', location: '823k · München', dnaMatch: 82, styleTag: 'Quiet Luxury', followers: 823000, isFollowing: true),
    FollowerUser(name: 'Sophie Anderson', location: '847 · Berlin', dnaMatch: 82, styleTag: 'Quiet Luxury', followers: 847),
    FollowerUser(name: 'Lena Bauer', location: '1.1k · München', dnaMatch: 79, styleTag: 'Classic Minimal', followers: 1100),
  ];

  final newFollowers = [
    FollowerUser(name: 'Anna Fischer', location: '340 · Hamburg', dnaMatch: 77, styleTag: '', followers: 340),
    FollowerUser(name: 'Mia Schneider', location: '215 · Berlin', dnaMatch: 74, styleTag: '', followers: 215),
    FollowerUser(name: 'Clara Meyer', location: '890 · München', dnaMatch: 71, styleTag: '', followers: 890),
  ];

  @override
  void onInit() {
    super.onInit();
    // Init following states
    for (final u in [...suggested, ...newFollowers]) {
      followingStates[u.name] = u.isFollowing;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void toggleFollow(String name) {
    followingStates[name] = !(followingStates[name] ?? false);
  }

  void setFilter(FollowerFilter f) => selectedFilter.value = f;
}