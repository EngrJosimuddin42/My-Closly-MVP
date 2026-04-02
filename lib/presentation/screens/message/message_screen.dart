import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'message_controller.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(
      builder: (controller) => Obx(() {
        if (controller.selectedUser.value != null) {
          return _ChatScreen();
        }
        return _ConversationListScreen();
      }),
    );
  }
}

// ─── Conversation List ────────────────────────────────────────────
class _ConversationListScreen extends GetView<MessageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // AppBar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('my', style: AppTextStyles.caption),
                    Text('Closly.', style: AppTextStyles.headlineLarge.copyWith(height: 0.9)),
                  ]),
                  Container(
                    width: 38, height: 38,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(Icons.notifications_none, size: 20, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.border),
                ),
                child: TextField(
                  controller: controller.searchController,
                  style: AppTextStyles.bodyMedium,
                  decoration: InputDecoration(
                    hintText: 'Search conversations',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textTertiary),
                    prefixIcon: const Icon(Icons.search, color: AppColors.textTertiary, size: 20),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Active Now section
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 12),
                    child: Text('ACTIVE NOW',
                        style: AppTextStyles.caption.copyWith(
                            color: AppColors.textTertiary, letterSpacing: 0.8)),
                  ),
                  SizedBox(
                    height: 90,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.activeUsers.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 16),
                      itemBuilder: (_, i) {
                        final user = controller.activeUsers[i];
                        return GestureDetector(
                          onTap: () => controller.openChat(user),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: user.avatarColor,
                                    child: Text(user.name[0],
                                        style: AppTextStyles.headlineSmall
                                            .copyWith(color: Colors.white)),
                                  ),
                                  if (user.isActive)
                                    Positioned(
                                      bottom: 2, right: 2,
                                      child: Container(
                                        width: 12, height: 12,
                                        decoration: BoxDecoration(
                                          color: AppColors.success,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 2),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(user.name,
                                  style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textPrimary)),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Messages section
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 12),
                    child: Text('MASSAGES',
                        style: AppTextStyles.caption.copyWith(
                            color: AppColors.textTertiary, letterSpacing: 0.8)),
                  ),

                  // Conversation list
                  ...controller.conversations.map((conv) => _ConversationTile(
                    user: conv,
                    onTap: () => controller.openChat(conv),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final ChatUser user;
  final VoidCallback onTap;
  const _ConversationTile({required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        color: Colors.transparent,
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: user.avatarColor,
                  child: Text(user.name[0],
                      style: AppTextStyles.headlineSmall.copyWith(color: Colors.white)),
                ),
                if (user.isActive)
                  Positioned(
                    bottom: 1, right: 1,
                    child: Container(
                      width: 11, height: 11,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: AppTextStyles.labelLarge),
                  const SizedBox(height: 3),
                  Text(user.lastMessage,
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Text(user.time,
                style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
          ],
        ),
      ),
    );
  }
}

// ─── Chat Screen ──────────────────────────────────────────────────
class _ChatScreen extends GetView<MessageController> {
  @override
  Widget build(BuildContext context) {
    final user = controller.selectedUser.value!;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Chat AppBar
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              color: Colors.white,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: controller.closeChat,
                    child: const Icon(Icons.arrow_back_ios_new,
                        size: 18, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 14),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: user.avatarColor,
                    child: Text(user.name[0],
                        style: AppTextStyles.labelMedium.copyWith(color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  Text(user.name, style: AppTextStyles.headlineSmall),
                ],
              ),
            ),

            // Messages
            Expanded(
              child: Obx(() => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (_, i) {
                  final msg = controller.messages[i];
                  return _MessageBubble(message: msg);
                },
              )),
            ),

            // Quick action chips
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: Row(
                children: [
                  _ActionChip(label: 'Add to closet',   onTap: controller.onAddToCloset),
                  const SizedBox(width: 8),
                  _ActionChip(label: 'Where to buy?',   onTap: controller.onWhereToBuy),
                  const SizedBox(width: 8),
                  _ActionChip(label: 'Similar styles?', onTap: controller.onSimilarStyles),
                ],
              ),
            ),

            // Message input bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
              child: Row(
                children: [
                  // Plus button
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                    ),
                    child: const Icon(Icons.add, size: 18, color: AppColors.textSecondary),
                  ),
                  const SizedBox(width: 10),

                  // Text input
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextField(
                        controller: controller.messageController,
                        style: AppTextStyles.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'Message...',
                          hintStyle: AppTextStyles.bodyMedium
                              .copyWith(color: AppColors.textTertiary),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        onSubmitted: (_) => controller.onSendMessage(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Send button
                  GestureDetector(
                    onTap: controller.onSendMessage,
                    child: Container(
                      width: 36, height: 36,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, size: 16, color: Colors.white),
                    ),
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

// ─── Message Bubble ───────────────────────────────────────────────
class _MessageBubble extends GetView<MessageController> {
  final ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;

    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // Product card (if any)
        if (message.product != null && !isMe) ...[
          _ProductCard(product: message.product!),
          const SizedBox(height: 6),
        ],

        // Text bubble
        if (message.text.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            decoration: BoxDecoration(
              color: isMe ? AppColors.primary : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isMe ? 18 : 4),
                bottomRight: Radius.circular(isMe ? 4 : 18),
              ),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4),
              ],
            ),
            child: Text(
              message.text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isMe ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ),

        // Time
        Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Text(message.time,
              style: AppTextStyles.caption.copyWith(color: AppColors.textTertiary)),
        ),
      ],
    );
  }
}

// ─── Product Card in Chat ─────────────────────────────────────────
class _ProductCard extends GetView<MessageController> {
  final ProductCard product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.72,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                child: Container(
                  height: 160,
                  color: const Color(0xFFD4A87A),
                  child: const Center(
                    child: Icon(Icons.dry_cleaning_outlined,
                        size: 60, color: Colors.white54),
                  ),
                ),
              ),
              // Match badge
              Positioned(
                top: 10, left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${product.matchPercent}% Match',
                    style: AppTextStyles.caption.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),

          // Product info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: AppTextStyles.labelLarge),
                const SizedBox(height: 2),
                Text(product.brand,
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(product.price, style: AppTextStyles.headlineSmall),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text('VIEW',
                              style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.textPrimary)),
                          const SizedBox(width: 4),
                          const Icon(Icons.arrow_forward, size: 14, color: AppColors.textPrimary),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.favorite_border, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text('2', style: AppTextStyles.bodySmall),
                    const SizedBox(width: 16),
                    const Icon(Icons.bookmark_border, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text('Save', style: AppTextStyles.bodySmall),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Action Chip ──────────────────────────────────────────────────
class _ActionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _ActionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(label, style: AppTextStyles.labelSmall),
      ),
    );
  }
}