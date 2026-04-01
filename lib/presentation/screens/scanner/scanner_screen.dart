import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/app_widgets.dart';
import 'scanner_controller.dart';

class ScannerScreen extends GetView<ScannerController> {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.scannerState.value) {
        case ScannerState.analyzing:
          return const _AnalyzingView();
        case ScannerState.result:
          return const _ResultView();
        case ScannerState.manual:
          return const _ManualView();
        case ScannerState.scanning:
        default:
          return const _ScanningView();
      }
    });
  }
}

// ─── Scanning State ───────────────────────────────────────────────
class _ScanningView extends GetView<ScannerController> {
  const _ScanningView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scannerBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Scanner',
                      style: AppTextStyles.headlineSmall.copyWith(color: Colors.white)),
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Scanner frame
            Stack(
              alignment: Alignment.center,
              children: [
                // Simulated camera view with item
                Container(
                  width: 280,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.scannerOverlay,
                  ),
                  child: Center(
                    child: Icon(Icons.directions_walk,
                        size: 120, color: Colors.white.withOpacity(0.2)),
                  ),
                ),
                // Corner brackets
                _ScannerFrame(),
                // Auto-detecting pill
                Positioned(
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'AUTO-DETECTING...',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Bottom controls
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ScanAction(
                        icon: Icons.edit_outlined,
                        label: 'MANUAL',
                        onTap: controller.onManual,
                      ),
                      // Shutter button
                      GestureDetector(
                        onTap: controller.onScan,
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            color: Colors.white.withOpacity(0.2),
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 32),
                        ),
                      ),
                      _ScanAction(
                        icon: Icons.photo_library_outlined,
                        label: 'GALLERY',
                        onTap: controller.onGallery,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Align item within frame for AI recognition.',
                    style: AppTextStyles.caption.copyWith(color: Colors.white60),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannerFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: CustomPaint(painter: _CornerBracketPainter()),
    );
  }
}

class _CornerBracketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const len = 30.0;
    const r = 12.0;

    // Top-left
    canvas.drawLine(Offset(r, 0), Offset(len, 0), paint);
    canvas.drawLine(Offset(0, r), Offset(0, len), paint);
    canvas.drawArc(const Rect.fromLTWH(0, 0, r * 2, r * 2), 3.14, 0.5, false, paint);

    // Top-right
    canvas.drawLine(Offset(size.width - len, 0), Offset(size.width - r, 0), paint);
    canvas.drawLine(Offset(size.width, r), Offset(size.width, len), paint);
    canvas.drawArc(Rect.fromLTWH(size.width - r * 2, 0, r * 2, r * 2), -1.57, -0.5, false, paint);

    // Bottom-left
    canvas.drawLine(Offset(0, size.height - len), Offset(0, size.height - r), paint);
    canvas.drawLine(Offset(r, size.height), Offset(len, size.height), paint);
    canvas.drawArc(Rect.fromLTWH(0, size.height - r * 2, r * 2, r * 2), 1.57, 0.5, false, paint);

    // Bottom-right
    canvas.drawLine(
        Offset(size.width - len, size.height), Offset(size.width - r, size.height), paint);
    canvas.drawLine(
        Offset(size.width, size.height - len), Offset(size.width, size.height - r), paint);
    canvas.drawArc(
        Rect.fromLTWH(size.width - r * 2, size.height - r * 2, r * 2, r * 2), 0, -0.5, false, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _ScanAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ScanAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.labelSmall.copyWith(color: Colors.white70)),
        ],
      ),
    );
  }
}

// ─── Analyzing State ──────────────────────────────────────────────
class _AnalyzingView extends StatefulWidget {
  const _AnalyzingView();

  @override
  State<_AnalyzingView> createState() => _AnalyzingViewState();
}

class _AnalyzingViewState extends State<_AnalyzingView>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.9, end: 1.1).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2A2A2A),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Scanner',
                      style: AppTextStyles.headlineSmall.copyWith(color: Colors.white)),
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.12),
                      ),
                      child: const Icon(Icons.close, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            ScaleTransition(
              scale: _pulse,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Icon(Icons.auto_awesome, color: Colors.white, size: 40),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Text('Analyzing Item...',
                style: AppTextStyles.headlineMedium.copyWith(color: Colors.white)),
            const SizedBox(height: 10),
            Text(
              'Using invisible AI to identify material,\nsize, and category.',
              style: AppTextStyles.bodySmall.copyWith(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// ─── Result State ─────────────────────────────────────────────────
class _ResultView extends GetView<ScannerController> {
  const _ResultView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: Get.back,
        ),
        title: Text('Add New Item', style: AppTextStyles.headlineSmall),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Item preview row
                  Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors.scannerBackground.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.directions_walk,
                            size: 40, color: AppColors.scannerBackground),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AiMatchBadge(percentage: 96),
                            const SizedBox(height: 8),
                            Text('Classic Sport shoe',
                                style: AppTextStyles.headlineSmall),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: controller.onRetake,
                              child: Row(
                                children: [
                                  const Icon(Icons.refresh,
                                      size: 14, color: AppColors.textTertiary),
                                  const SizedBox(width: 4),
                                  Text('RETAKE',
                                      style: AppTextStyles.labelSmall.copyWith(
                                          color: AppColors.textTertiary)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Attributes
                  Row(
                    children: const [
                      Expanded(child: _AttrChip(label: 'SIZE', value: 'M')),
                      SizedBox(width: 12),
                      Expanded(child: _ColorAttrChip()),
                      SizedBox(width: 12),
                      Expanded(child: _AttrChip(label: 'BRAND', value: 'Gap Kids')),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              'This item will be saved to your private inventory.',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: AppOutlineButton(
                    label: 'Scan another',
                    onTap: controller.onScanAnother,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppPrimaryButton(
                    label: 'Save',
                    onTap: controller.onSaveItem,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _AttrChip extends StatelessWidget {
  final String label;
  final String value;
  const _AttrChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.caption),
          const SizedBox(height: 4),
          Text(value, style: AppTextStyles.labelMedium),
        ],
      ),
    );
  }
}

class _ColorAttrChip extends StatelessWidget {
  const _ColorAttrChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('COLOR', style: AppTextStyles.caption),
          const SizedBox(height: 4),
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Color(0xFF1A1A2E),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Manual State ─────────────────────────────────────────────────
class _ManualView extends GetView<ScannerController> {
  const _ManualView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18),
          onPressed: () => controller.scannerState.value = ScannerState.scanning,
        ),
        title: Text('Add New Item', style: AppTextStyles.headlineSmall),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image + Name
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(Icons.upload_outlined,
                            color: AppColors.textTertiary, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ITEM NAME', style: AppTextStyles.caption),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.surfaceVariant,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: TextField(
                                controller: controller.itemNameController,
                                style: AppTextStyles.bodyMedium,
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Enter Item Name',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Quantity
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('QUANTITY', style: AppTextStyles.caption),
                      Obx(() => Row(
                        children: [
                          _QtyButton(
                            icon: Icons.remove,
                            onTap: controller.decrementQuantity,
                          ),
                          const SizedBox(width: 16),
                          Text('${controller.manualQuantity.value}',
                              style: AppTextStyles.headlineSmall),
                          const SizedBox(width: 16),
                          _QtyButton(
                            icon: Icons.add,
                            onTap: controller.incrementQuantity,
                          ),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Attributes
                  Row(
                    children: [
                      _AttrChip(label: 'SIZE', value: 'M'),
                      const SizedBox(width: 12),
                      _ColorAttrChip(),
                      const SizedBox(width: 12),
                      _AttrChip(label: 'BRAND', value: 'Gap Kids'),
                    ].map((w) => Expanded(child: w)).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'This item will be saved to your private inventory.',
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: AppOutlineButton(
                    label: 'Scan another',
                    onTap: controller.onScanAnother,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppPrimaryButton(
                    label: 'Save',
                    onTap: controller.onSaveManual,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 16, color: AppColors.textPrimary),
      ),
    );
  }
}