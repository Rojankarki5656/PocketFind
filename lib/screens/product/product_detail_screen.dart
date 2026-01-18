import 'package:flutter/material.dart';
import 'package:pocketfind/core/theme/app_theme.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productName;

  const ProductDetailScreen({super.key, required this.productName});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> priceComparison = [
      {'shop': 'A Shop', 'price': 100, 'distance': 200, 'isCheapest': true},
      {'shop': 'B Shop', 'price': 120, 'distance': 350, 'isCheapest': false},
      {'shop': 'C Shop', 'price': 110, 'distance': 500, 'isCheapest': false},
      {'shop': 'D Shop', 'price': 130, 'distance': 180, 'isCheapest': false},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(Icons.photo, size: 60, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            
            // Product Name
            Text(
              productName,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            
            // Average Price
            Row(
              children: [
                const Icon(Icons.currency_rupee, size: 20, color: Colors.green),
                const SizedBox(width: 4),
                Text(
                  'Average: ₹115',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Price Comparison
            const Text(
              'Price Comparison',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            DataTable(
              columns: const [
                DataColumn(label: Text('Shop')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Distance')),
              ],
              rows: priceComparison.map((data) {
                return DataRow(
                  cells: [
                    DataCell(Row(
                      children: [
                        Text(data['shop']),
                        if (data['isCheapest'])
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                      ],
                    )),
                    DataCell(Text(
                      '₹${data['price']}',
                      style: TextStyle(
                        fontWeight: data['isCheapest'] ? FontWeight.bold : FontWeight.normal,
                        color: data['isCheapest'] ? AppTheme.primaryColor : null,
                      ),
                    )),
                    DataCell(Text('${data['distance']}m')),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.directions),
                    label: const Text('Get directions'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.flag),
                    label: const Text('Report'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border),
              label: const Text('Save Product'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}