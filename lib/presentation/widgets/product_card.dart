import 'package:flutter/material.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/product_entity.dart';

class SmallProductCard extends StatelessWidget {
  final ProductEntity product;
  const SmallProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFB0A098),
          borderRadius: BorderRadius.circular(14)
      ),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                  color: const Color(0xFFB0A098),
                  child: const Center(
                      child: Icon(Icons.checkroom_outlined, size: 50, color: Colors.white30)
                  )
              )
          ),
          // Favorite button (আপনি চাইলে এটিকেও এখানে রাখতে পারেন)
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.55)]
                ),
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(14)
                ),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.brand.toUpperCase(),
                        style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                    Text(product.name,
                        style: AppTextStyles.labelMedium.copyWith(color: Colors.white, fontSize: 12),
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(product.formattedPrice,
                        style: AppTextStyles.caption.copyWith(color: Colors.white60)),
                  ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}