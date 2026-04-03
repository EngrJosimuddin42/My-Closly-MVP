import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'closet_points_controller.dart';

class ClosetPointsScreen extends GetView<ClosetPointsController> {
  const ClosetPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverToBoxAdapter(child: _PointsHeader()),
          SliverPersistentHeader(
            pinned: true,
            delegate: _PointsTabDelegate(),
          ),
        ],
        body: Obx(() {
          switch (controller.currentTab.value) {
            case PointsTab.rewards: return _RewardsTab();
            case PointsTab.activity: return _ActivityTab();
            default: return _WaysToEarnTab();
          }
        }),
      ),
    );
  }
}

// ─── Header ───────────────────────────────────────────────────────
class _PointsHeader extends GetView<ClosetPointsController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Color(0xCC1A1A1A), BlendMode.multiply),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              GestureDetector(
                onTap: Get.back,
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 16),

              Center(
                child: Text('Closet Points',
                    style: AppTextStyles.headlineMedium.copyWith(color: Colors.white)),
              ),
              const SizedBox(height: 20),

              // Points balance
              Text('YOUR BALANCE',
                  style: AppTextStyles.caption.copyWith(color: Colors.white60, letterSpacing: 1.2)),
              const SizedBox(height: 8),

              Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${controller.totalPoints.value}',
                      style: const TextStyle(
                        fontFamily: 'serif',
                        fontSize: 52,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1,
                      )),
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('pts',
                        style: AppTextStyles.bodyMediumWhite.copyWith(color: Colors.white70)),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(controller.tier.value,
                          style: AppTextStyles.labelLarge.copyWith(color: Colors.white)),
                      Text('tier',
                          style: AppTextStyles.caption.copyWith(color: Colors.white60)),
                    ],
                  ),
                ],
              )),
              const SizedBox(height: 12),

              // Progress bar
              Obx(() => ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: controller.progressValue,
                  backgroundColor: Colors.white24,
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF4A90D9)),
                  minHeight: 5,
                ),
              )),
              const SizedBox(height: 8),

              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Gold: ${controller.totalPoints.value} pts',
                      style: AppTextStyles.caption.copyWith(color: Colors.white54)),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      '${controller.pointsToNext} to ${controller.nextTier} →',
                      style: AppTextStyles.caption.copyWith(color: Colors.white70),
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 10),

              // Monthly
              Obx(() => Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('+${controller.monthlyPoints.value} pts',
                        style: AppTextStyles.caption.copyWith(
                            color: AppColors.success, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(width: 8),
                  Text('this month · on track for Style Curator',
                      style: AppTextStyles.caption.copyWith(color: Colors.white60)),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Tab Bar ──────────────────────────────────────────────────────
class _PointsTabDelegate extends SliverPersistentHeaderDelegate {
  static const _tabs = [
    {'label': 'WAYS TO EARN', 'tab': PointsTab.waysToEarn},
    {'label': 'REWARDS', 'tab': PointsTab.rewards},
    {'label': 'ACTIVITY', 'tab': PointsTab.activity},
  ];

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final controller = Get.find<ClosetPointsController>();
    return Container(
      color: Colors.white,
      child: Obx(() => Row(
        children: _tabs.map((t) {
          final isSelected = controller.currentTab.value == t['tab'];
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.setTab(t['tab'] as PointsTab),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? AppColors.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  t['label'] as String,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.caption.copyWith(
                    color: isSelected ? AppColors.primary : AppColors.textTertiary,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      )),
    );
  }

  @override double get maxExtent => 44;
  @override double get minExtent => 44;
  @override bool shouldRebuild(_) => true;
}

// ─── Ways To Earn Tab ─────────────────────────────────────────────
class _WaysToEarnTab extends GetView<ClosetPointsController> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: controller.waysToEarn.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          color: Colors.white,
          child: Row(
            children: [
              Container(
                width: 44, height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF0FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item['icon'] as IconData,
                    size: 22, color: const Color(0xFF4A90D9)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item['title'] as String, style: AppTextStyles.labelLarge),
                    Text(item['desc'] as String, style: AppTextStyles.bodySmall),
                  ],
                ),
              ),
              Text(item['pts'] as String,
                  style: AppTextStyles.headlineSmall.copyWith(
                      color: const Color(0xFF4A90D9))),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─── Rewards Tab ──────────────────────────────────────────────────
class _RewardsTab extends GetView<ClosetPointsController> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('Redeem Your Points', style: AppTextStyles.headlineMedium),
        const SizedBox(height: 4),
        Text('Exclusive rewards & vouchers for your style',
            style: AppTextStyles.bodyMedium),
        const SizedBox(height: 14),

        // Points pill
        Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceVariant,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.label_outline, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              Text('${controller.totalPoints.value} pts available',
                  style: AppTextStyles.labelMedium),
            ],
          ),
        )),
        const SizedBox(height: 20),

        ...controller.rewards.map((r) => _RewardItem(reward: r,
            onRedeem: () => controller.onRedeem(r))),
      ],
    );
  }
}

class _RewardItem extends StatelessWidget {
  final Map reward;
  final VoidCallback onRedeem;
  const _RewardItem({required this.reward, required this.onRedeem});

  @override
  Widget build(BuildContext context) {
    final tierColors = {
      'BRONZE': const Color(0xFFC07838),
      'SILVER': const Color(0xFF8A8A9A),
      'GOLD': const Color(0xFFB8900A),
    };
    final tierColor = tierColors[reward['tier']] ?? AppColors.textSecondary;
    final canAfford = reward['canAfford'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(reward['tier'] as String,
              style: AppTextStyles.caption.copyWith(color: tierColor, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(reward['title'] as String, style: AppTextStyles.labelLarge),
                    const SizedBox(height: 2),
                    Text('${reward['pts']} points', style: AppTextStyles.bodySmall),
                    if (canAfford)
                      Row(
                        children: [
                          const Icon(Icons.check, size: 12, color: AppColors.success),
                          const SizedBox(width: 4),
                          Text('You can afford this',
                              style: AppTextStyles.caption.copyWith(color: AppColors.success)),
                        ],
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: canAfford ? onRedeem : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  disabledBackgroundColor: AppColors.border,
                  minimumSize: const Size(80, 36),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text('Redeem',
                    style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Activity Tab ─────────────────────────────────────────────────
class _ActivityTab extends GetView<ClosetPointsController> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('MARCH 2026',
            style: AppTextStyles.caption.copyWith(
                color: AppColors.textTertiary, letterSpacing: 1)),
        const SizedBox(height: 12),
        ...controller.activity.map((a) => _ActivityItem(item: a)),
      ],
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final Map item;
  const _ActivityItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final isPositive = item['positive'] as bool;
    final iconColor = Color(item['color'] as int);

    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 42, height: 42,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(item['icon'] as IconData, size: 20, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title'] as String, style: AppTextStyles.labelLarge),
                Text(item['detail'] as String, style: AppTextStyles.bodySmall),
                Text(item['time'] as String,
                    style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
              ],
            ),
          ),
          Text(
            item['pts'] as String,
            style: AppTextStyles.headlineSmall.copyWith(
              color: isPositive ? const Color(0xFF4A90D9) : const Color(0xFFE8A020),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}