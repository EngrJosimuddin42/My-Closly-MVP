import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/product_entity.dart';
import '../../widgets/app_widgets.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _HomeAppBar(),
            _FeedTabBar(),
            Expanded(
              child: Obx(() {
                switch (controller.selectedFeedTab.value) {
                  case 1:
                    return const _FollowsTab();
                  case 2:
                    return const _YourDayTab();
                  default:
                    return const _ForYouTab();
                }
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(),
    );
  }
}

// ─── AppBar ───────────────────────────────────────────────────────
class _HomeAppBar extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('my', style: AppTextStyles.caption),
              Text('Closly.',
                  style: AppTextStyles.headlineLarge.copyWith(height: 0.9)),
            ],
          ),
          Row(
            children: [
              _IconBtn(icon: Icons.search, onTap: () {}),
              const SizedBox(width: 10),
              _IconBtn(icon: Icons.notifications_none, onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class _IconBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _IconBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 18, color: AppColors.textSecondary),
      ),
    );
  }
}

// ─── Tab Bar ──────────────────────────────────────────────────────
class _FeedTabBar extends GetView<HomeController> {
  final tabs = const ['For You', 'Follows', 'Your Day'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Obx(() => Row(
        children: List.generate(tabs.length, (i) {
          final isSelected = controller.selectedFeedTab.value == i;
          return GestureDetector(
            onTap: () => controller.setFeedTab(i),
            child: Padding(
              padding: EdgeInsets.only(right: i < tabs.length - 1 ? 24 : 0),
              child: Column(
                children: [
                  Text(
                    tabs[i],
                    style: isSelected
                        ? AppTextStyles.labelLarge.copyWith(color: AppColors.primary)
                        : AppTextStyles.labelLarge.copyWith(color: AppColors.textTertiary),
                  ),
                  const SizedBox(height: 6),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 2,
                    width: isSelected ? 24 : 0,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      )),
    );
  }
}

// ─── For You Tab ──────────────────────────────────────────────────
class _ForYouTab extends GetView<HomeController> {
  const _ForYouTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      children: [
        // Hero product card
        _HeroProductCard(product: controller.forYouProducts[0]),
        const SizedBox(height: 14),

        // Small product grid
        Row(
          children: [
            Expanded(child: _SmallProductCard(product: controller.forYouProducts[1])),
            const SizedBox(width: 12),
            Expanded(child: _SmallProductCard(product: controller.forYouProducts[2])),
          ],
        ),
        const SizedBox(height: 20),

        // Expand your style section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Expand your style', style: AppTextStyles.headlineSmall),
            Row(
              children: [
                Text('See all', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary)),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_forward_ios, size: 11, color: AppColors.primary),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: _SmallProductCard(product: controller.forYouProducts[1])),
            const SizedBox(width: 12),
            Expanded(child: _SmallProductCard(product: controller.forYouProducts[2])),
          ],
        ),
      ],
    );
  }
}

class _HeroProductCard extends GetView<HomeController> {
  final ProductEntity product;
  const _HeroProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showProductSheet(context, product),
      child: Container(
        height: 240,
        decoration: BoxDecoration(
          color: const Color(0xFF8A7B6F),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: const Color(0xFFA89280),
                child: const Center(
                  child: Icon(Icons.dry_cleaning_outlined,
                      size: 80, color: Colors.white30),
                ),
              ),
            ),
            Positioned(
              top: 12, right: 12,
              child: _FavoriteBtn(isFaved: product.isFavorited),
            ),
            Positioned(
              bottom: 0, left: 0, right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.brand.toUpperCase(),
                        style: AppTextStyles.overline.copyWith(color: Colors.white70)),
                    Text(product.name,
                        style: AppTextStyles.headlineSmall.copyWith(color: Colors.white)),
                    Text(product.formattedPrice,
                        style: AppTextStyles.bodyMedium.copyWith(color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductSheet(BuildContext context, ProductEntity product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ProductSheet(product: product),
    );
  }
}

class _SmallProductCard extends StatelessWidget {
  final ProductEntity product;
  const _SmallProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: const Color(0xFFB0A098),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              color: const Color(0xFFB0A098),
              child: const Center(
                child: Icon(Icons.checkroom_outlined,
                    size: 50, color: Colors.white30),
              ),
            ),
          ),
          Positioned(
            top: 8, right: 8,
            child: _FavoriteBtn(isFaved: false, small: true),
          ),
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.55)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.brand.toUpperCase(),
                      style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                  Text(product.name,
                      style: AppTextStyles.labelMedium.copyWith(
                          color: Colors.white, fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  Text(product.formattedPrice,
                      style: AppTextStyles.caption.copyWith(color: Colors.white60)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteBtn extends StatefulWidget {
  final bool isFaved;
  final bool small;
  const _FavoriteBtn({this.isFaved = false, this.small = false});

  @override
  State<_FavoriteBtn> createState() => _FavoriteBtnState();
}

class _FavoriteBtnState extends State<_FavoriteBtn> {
  late bool _faved;

  @override
  void initState() {
    super.initState();
    _faved = widget.isFaved;
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.small ? 30.0 : 36.0;
    return GestureDetector(
      onTap: () => setState(() => _faved = !_faved),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.85),
        ),
        child: Icon(
          _faved ? Icons.favorite : Icons.favorite_border,
          size: size * 0.5,
          color: _faved ? Colors.red : AppColors.textSecondary,
        ),
      ),
    );
  }
}

// ─── Product Bottom Sheet ─────────────────────────────────────────
class _ProductSheet extends GetView<HomeController> {
  final ProductEntity product;
  const _ProductSheet({required this.product});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, scroll) => Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ListView(
          controller: scroll,
          padding: EdgeInsets.zero,
          children: [
            // Product image
            Container(
              height: 320,
              decoration: const BoxDecoration(
                color: Color(0xFFB0A098),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  const Center(
                    child: Icon(Icons.dry_cleaning_outlined,
                        size: 100, color: Colors.white30),
                  ),
                  Positioned(
                    top: 16, right: 16,
                    child: _FavoriteBtn(isFaved: product.isFavorited),
                  ),
                  Positioned(
                    top: 16, left: 16,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.85),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new,
                            size: 16, color: AppColors.textPrimary),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: AppTextStyles.headlineLarge),
                  const SizedBox(height: 4),
                  Text(product.formattedPrice,
                      style: AppTextStyles.headlineMedium.copyWith(
                          color: AppColors.textSecondary)),
                  const SizedBox(height: 12),

                  // Match badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: AppColors.aiMatchBadge.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.aiMatchBadge.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.auto_awesome,
                            size: 14, color: AppColors.aiMatchBadge),
                        const SizedBox(width: 6),
                        Text('96% MATCH',
                            style: AppTextStyles.labelMedium
                                .copyWith(color: AppColors.aiMatchBadge)),
                        const SizedBox(width: 8),
                        Text('Matches your style perfectly',
                            style: AppTextStyles.bodySmall),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Size selector
                  Text('Size', style: AppTextStyles.labelMedium),
                  const SizedBox(height: 10),
                  Obx(() => SizeSelector(
                    sizes: controller.sizes,
                    selectedSize: controller.selectedSize.value,
                    onSelected: controller.selectSize,
                  )),
                  const SizedBox(height: 16),

                  // Closet match
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Mini avatars
                        SizedBox(
                          width: 60,
                          height: 24,
                          child: Stack(
                            children: List.generate(3, (i) => Positioned(
                              left: i * 16.0,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.accent.withOpacity(0.3 + i * 0.2),
                                  border: Border.all(color: Colors.white, width: 1.5),
                                ),
                              ),
                            )),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Matches 8 pieces already in your closet — White Tee, Black Trousers & more',
                            style: AppTextStyles.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Shop Now
                  AppPrimaryButton(
                    label: 'SHOP NOW →',
                    onTap: controller.onShopNow,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Follows Tab ──────────────────────────────────────────────────
class _FollowsTab extends GetView<HomeController> {
  const _FollowsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      children: [
        Text('TRENDING IN YOUR CIRCLE',
            style: AppTextStyles.overline),
        const SizedBox(height: 12),

        // Trending row
        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: controller.followsProducts.map((p) =>
                Container(
                  width: 90,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8A7B6F),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      const Center(
                        child: Icon(Icons.checkroom_outlined, color: Colors.white30),
                      ),
                      Positioned(
                        bottom: 6, left: 6, right: 6,
                        child: Text(p.name,
                            style: AppTextStyles.caption.copyWith(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
            ).toList(),
          ),
        ),
        const SizedBox(height: 20),

        // Social feed
        ...[
          _SocialFeedItem(
            userName: 'Sarah M.',
            action: 'liked this',
            product: controller.forYouProducts[1],
          ),
          const SizedBox(height: 12),
          _SocialFeedItem(
            userName: 'Sarah M.',
            action: 'bought this',
            product: controller.forYouProducts[1],
          ),
        ],
      ],
    );
  }
}

class _SocialFeedItem extends StatelessWidget {
  final String userName;
  final String action;
  final ProductEntity product;
  const _SocialFeedItem({
    required this.userName,
    required this.action,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withOpacity(0.3),
                  ),
                  child: const Icon(Icons.person, size: 16, color: AppColors.accent),
                ),
                const SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    style: AppTextStyles.bodySmall,
                    children: [
                      TextSpan(text: '$userName ',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      TextSpan(text: action),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Color(0xFFB0A098),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(Icons.checkroom_outlined,
                      size: 60, color: Colors.white30),
                ),
                Positioned(
                  top: 12, right: 12,
                  child: _FavoriteBtn(small: true),
                ),
                Positioned(
                  bottom: 0, left: 0, right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('OTHER STORIES',
                            style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                        Text(product.name,
                            style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                        Text(product.formattedPrice,
                            style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Your Day Tab ─────────────────────────────────────────────────
class _YourDayTab extends GetView<HomeController> {
  const _YourDayTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      children: [
        // Weather card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF4A7CB5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('MÜNCHEN',
                      style: AppTextStyles.caption.copyWith(color: Colors.white60)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Obx(() => Text('${controller.weatherTemp.value}',
                          style: AppTextStyles.displayMediumWhite.copyWith(fontSize: 40))),
                      Text(' °C',
                          style: AppTextStyles.headlineMedium.copyWith(color: Colors.white70)),
                    ],
                  ),
                  Obx(() => Text(controller.weatherDesc.value,
                      style: AppTextStyles.bodySmall.copyWith(color: Colors.white70))),
                ],
              ),
              const Spacer(),
              const Icon(Icons.wb_cloudy_outlined, color: Colors.white, size: 48),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // AI outfit suggestion
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome, size: 14, color: AppColors.aiMatchBadge),
                  const SizedBox(width: 6),
                  Text('AI OUTFIT FOR TODAY',
                      style: AppTextStyles.overline.copyWith(color: AppColors.aiMatchBadge)),
                ],
              ),
              const SizedBox(height: 10),
              Obx(() => Text(controller.aiOutfitDesc.value,
                  style: AppTextStyles.bodyMedium)),
              const SizedBox(height: 14),

              // Outfit grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _OutfitItem(label: 'COS', name: 'Linen Blazer'),
                  _OutfitItem(label: 'ARKET', name: 'Ribbed Tee'),
                  _OutfitItem(label: 'TOTEME', name: 'Trousers'),
                  _OutfitItem(label: 'A.P.C', name: 'Loafers'),
                ],
              ),
              const SizedBox(height: 14),

              // Log button
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Wearing this today?',
                          style: AppTextStyles.bodySmall.copyWith(color: Colors.white)),
                      const SizedBox(width: 8),
                      Text('Log +50 pts',
                          style: AppTextStyles.labelSmall.copyWith(
                              color: Colors.white, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OutfitItem extends StatelessWidget {
  final String label;
  final String name;
  const _OutfitItem({required this.label, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFB0A098),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          const Center(
            child: Icon(Icons.checkroom_outlined, color: Colors.white30, size: 32),
          ),
          Positioned(
            bottom: 6, left: 8, right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                Text(name,
                    style: AppTextStyles.labelSmall.copyWith(color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Nav ───────────────────────────────────────────────────
class _BottomNav extends GetView<HomeController> {
  // আইটেমগুলোকে আলাদাভাবে ডিফাইন করা ভালো
  final List<NavigationItem> _items = const [
    NavigationItem(icon: Icons.home_outlined, label: 'Home'),
    NavigationItem(icon: Icons.send_outlined, label: 'Message'),
    NavigationItem(icon: Icons.checkroom_outlined, label: 'Closet'),
    NavigationItem(icon: Icons.person_outline, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.divider,
            width: 0.5)), // চিকন বর্ডার বেশি সুন্দর দেখায়
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: Obx(() =>
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_items.length, (index) {
                  final isSelected = controller.navIndex.value == index;
                  final item = _items[index];

                  return InkWell( // Ripple effect এর জন্য
                    onTap: () => _handleNavigation(index),
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.icon,
                            size: 26, // সাইজ সামান্য বাড়ানো হয়েছে
                            color: isSelected ? AppColors.primary : AppColors
                                .textTertiary,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.label,
                            style: AppTextStyles.caption.copyWith(
                              fontSize: 11,
                              color: isSelected ? AppColors.primary : AppColors
                                  .textTertiary,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )),
        ),
      ),
    );
  }

  void _handleNavigation(int index) {
    if (index == 2) {
      controller.onClosetTap();
    } else if (index == 3) {
      controller.onProfileTap();
    } else {
      controller.setNavIndex(index);
    }
  }
}

  class NavigationItem {
  final IconData icon;
  final String label;

  const NavigationItem({
  required this.icon,
  required this.label
  });
  }
