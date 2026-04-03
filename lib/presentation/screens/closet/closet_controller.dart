import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class ClosetItem {
  final String id;
  final String name;
  final String brand;
  final String category;
  final Color color;
  final double costPerWear;
  final int timesWorn;
  final int daysUnworn;
  final bool isGhost;
  final String size;
  final String season;
  final String styleMatch;

  const ClosetItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.color,
    this.costPerWear = 0,
    this.timesWorn = 0,
    this.daysUnworn = 0,
    this.isGhost = false,
    this.size = 'S',
    this.season = 'Spring · Summer',
    this.styleMatch = 'Minimal',
  });
}

class ClosetController extends GetxController {
  final closetScore = 74.obs;
  final maxScore = 100.obs;
  final costPerWear = 2.41.obs;
  final closetPoints = 1370.obs;
  final selectedFilter = 'All'.obs;

  final allItems = <ClosetItem>[
    ClosetItem(id:'1', name:'Linen Blazer',    brand:'Arket',   category:'Tops',    color:Color(0xFFD4B896), costPerWear:0.80, timesWorn:42, daysUnworn:3,   size:'S', season:'Spring · Summer', styleMatch:'Minimal'),
    ClosetItem(id:'2', name:'White Tee',       brand:'Arket',   category:'Tops',    color:Color(0xFFF0EBE6), costPerWear:0.65, timesWorn:80, daysUnworn:1,   size:'S', season:'All Season',      styleMatch:'Minimal'),
    ClosetItem(id:'3', name:'Mini Bag',        brand:'Mango',   category:'Bags',    color:Color(0xFFC4956A), costPerWear:1.20, timesWorn:15, daysUnworn:10,  size:'OS',season:'All Season',      styleMatch:'Elegant'),
    ClosetItem(id:'4', name:'Leather Tote',    brand:'Suzane',  category:'Bags',    color:Color(0xFF8A6A5A), costPerWear:1.80, timesWorn:8,  daysUnworn:30,  size:'OS',season:'All Season',      styleMatch:'Classic'),
    ClosetItem(id:'5', name:'Black Trousers',  brand:'Toteme',  category:'Bottoms', color:Color(0xFF2A2A2A), costPerWear:1.10, timesWorn:35, daysUnworn:5,   size:'S', season:'All Season',      styleMatch:'Minimal'),
    ClosetItem(id:'6', name:'Loafers',         brand:'Everlane',category:'Shoes',   color:Color(0xFF8A7060), costPerWear:1.50, timesWorn:20, daysUnworn:15,  size:'38',season:'Spring · Summer', styleMatch:'Classic'),
    ClosetItem(id:'7', name:'Silk Dress',      brand:'COS',     category:'Tops',    color:Color(0xFFD4C8B8), costPerWear:3.20, timesWorn:5,  daysUnworn:127, isGhost:true, size:'S', season:'Summer', styleMatch:'Elegant'),
    ClosetItem(id:'8', name:'Red Blazer',      brand:'Zara',    category:'Tops',    color:Color(0xFFB03020), costPerWear:4.50, timesWorn:3,  daysUnworn:200, isGhost:true, size:'S', season:'Autumn', styleMatch:'Statement'),
  ].obs;

  final filters = ['All', 'Tops', 'Bottoms', 'Shoes', 'Bags'];

  List<ClosetItem> get filteredItems {
    if (selectedFilter.value == 'All') return allItems;
    return allItems.where((i) => i.category == selectedFilter.value).toList();
  }

  List<ClosetItem> get ghostItems => allItems.where((i) => i.isGhost).toList();
  int get totalPieces => allItems.length;

  // Style DNA scores
  final styleDna = {
    'Minimal':    72,
    'Classic':    64,
    'Casual':     38,
    'Elegant':    36,
    'Structured': 32,
  };

  void setFilter(String f) => selectedFilter.value = f;

  void onAddManually()  => Get.toNamed(AppRoutes.scanner);
  void onUploadPhoto()  => Get.toNamed(AppRoutes.scanner);

  void onAllPieces()    => Get.toNamed(AppRoutes.closetAllPieces);
  void onGhostPieces()  => Get.toNamed(AppRoutes.closetGhostPieces);
  void onAudit()        => Get.toNamed(AppRoutes.closetAudit);
  void onTodayWear()    => Get.toNamed(AppRoutes.closetTodayWear);

  void onItemTap(ClosetItem item) =>
      Get.toNamed(AppRoutes.closetItemDetail, arguments: item);
}