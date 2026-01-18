import 'package:flutter/material.dart';
import 'package:pocketfind/core/theme/app_theme.dart';
class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final String shop;
  final int distance;
  final int? originalPrice;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.shop,
    required this.distance,
    this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (originalPrice != null)
                  Text(
                    '₹$originalPrice',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '₹$price',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.store, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  shop,
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                const Icon(Icons.directions_walk, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${distance}m',
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'View',
                    style: TextStyle(color: Colors.white, fontSize: 12),
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