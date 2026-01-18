import 'package:flutter/material.dart';
import 'package:pocketfind/core/theme/app_theme.dart';

class HiddenGemsCard extends StatelessWidget {
  final List<Map<String, dynamic>> hiddenGems;

  const HiddenGemsCard({super.key, required this.hiddenGems});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: hiddenGems.length,
        itemBuilder: (context, index) {
          final gem = hiddenGems[index];
          print(gem);
          return _GemCard(gem: gem, isLast: index == hiddenGems.length - 1);
        },
      ),
    );
  }
}

class _GemCard extends StatelessWidget {
  final Map<String, dynamic> gem;
  final bool isLast;

  const _GemCard({required this.gem, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: EdgeInsets.only(right: isLast ? 0 : 16, bottom: 8, top: 4),
      decoration: BoxDecoration(
        // Premium Gradient Background
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.grey.shade50, // Subtle off-white for depth
          ],
        ),
        borderRadius: BorderRadius.circular(20), // Softer corners
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(
            0.1,
          ), // Very thin premium border
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Increased padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Badge(text: gem['badge']!),
              const SizedBox(height: 16),
              Text(
                gem['name']!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800, // Heavier weight
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '₹${gem['price']}',
                style: const TextStyle(
                  fontSize: 32, // Larger price
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                  letterSpacing: -1,
                ),
              ),
              const Spacer(), // Pushes shop info to the bottom
              _ShopInfo(shop: gem['shop']!, distance: gem['distance']),
            ],
          ),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String text;
  const _Badge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppTheme.accentColor,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _ShopInfo extends StatelessWidget {
  final String shop;
  final int distance;
  const _ShopInfo({required this.shop, required this.distance});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.store, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(shop, style: const TextStyle(color: Colors.grey)),
        const Spacer(),
        const Icon(Icons.directions_walk, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text('$distance m', style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
