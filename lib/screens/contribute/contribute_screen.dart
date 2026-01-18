import 'package:flutter/material.dart';
import 'package:pocketfind/models/contribution_model.dart';
import 'package:provider/provider.dart';
import 'package:pocketfind/services/user_provider.dart';
import 'package:pocketfind/core/theme/app_theme.dart';

class ContributeScreen extends StatefulWidget {
  const ContributeScreen({super.key});

  @override
  State<ContributeScreen> createState() => _ContributeScreenState();
}

class _ContributeScreenState extends State<ContributeScreen> {
  final List<Map<String, dynamic>> _contributeOptions = [
    {
      'icon': Icons.store,
      'title': 'Add New Shop',
      'subtitle': 'Add a shop that\'s not listed',
      'color': Colors.blue,
    },
    {
      'icon': Icons.add_shopping_cart,
      'title': 'Add Product & Price',
      'subtitle': 'Add a new product with price',
      'color': Colors.green,
    },
    {
      'icon': Icons.edit,
      'title': 'Update Price',
      'subtitle': 'Update price for existing product',
      'color': Colors.orange,
    },
    {
      'icon': Icons.photo_camera,
      'title': 'Add Photos',
      'subtitle': 'Upload product/shop photos',
      'color': Colors.purple,
    },
    {
      'icon': Icons.star,
      'title': 'Rate & Review',
      'subtitle': 'Rate shops and products',
      'color': Colors.red,
    },
    {
      'icon': Icons.flag,
      'title': 'Report Issues',
      'subtitle': 'Report wrong info or issues',
      'color': Colors.brown,
    },
  ];

  void _showContributionDialog(String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildContributionForm(type),
    );
  }

  Widget _buildContributionForm(String type) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final TextEditingController shopController = TextEditingController();
    final TextEditingController productController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                type == 'shop' ? 'Add New Shop' : 
                type == 'product' ? 'Add Product' : 'Update Price',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          if (type != 'price_update')
          Column(
            children: [
              TextFormField(
                controller: type == 'shop' ? shopController : productController,
                decoration: InputDecoration(
                  labelText: type == 'shop' ? 'Shop Name' : 'Product Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          
          if (type == 'price_update')
          Column(
            children: [
              TextFormField(
                controller: shopController,
                decoration: const InputDecoration(
                  labelText: 'Shop Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: productController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          
          TextFormField(
            controller: priceController,
            decoration: const InputDecoration(
              labelText: 'Price (₹)',
              border: OutlineInputBorder(),
              prefixText: '₹ ',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          
          // Photo upload
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt, color: Colors.grey, size: 30),
                  SizedBox(height: 8),
                  Text('Add Photo (Optional)'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final points = type == 'shop' ? 50 : 10;
                userProvider.addContribution(
                  Contribution(
                    id: 'cont_${DateTime.now().millisecondsSinceEpoch}',
                    type: type,
                    name: type == 'shop' 
                      ? shopController.text 
                      : productController.text,
                    date: DateTime.now(),
                    pointsEarned: points,
                  ),
                );
                
                Navigator.pop(context);
                
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.celebration, color: Colors.white),
                        const SizedBox(width: 8),
                        Text('You earned +$points points 🎉'),
                      ],
                    ),
                    backgroundColor: AppTheme.primaryColor,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Submit Contribution',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contribute'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Points Card
            Card(
              color: AppTheme.primaryColor.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: AppTheme.primaryColor,
                      child: Icon(
                        Icons.emoji_events,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user?.points ?? 0} Points',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${user?.badge ?? 'Explorer'}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: (user?.points ?? 0) / 2000,
                            backgroundColor: Colors.grey.shade200,
                            color: AppTheme.primaryColor,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${((user?.points ?? 0) / 2000 * 100).toStringAsFixed(0)}% to Super Contributor',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Quick Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  icon: Icons.store,
                  value: '${user?.contributions.where((c) => c.type == 'shop').length ?? 0}',
                  label: 'Shops',
                  color: Colors.blue,
                ),
                _buildStatItem(
                  icon: Icons.shopping_bag,
                  value: '${user?.contributions.where((c) => c.type == 'product').length ?? 0}',
                  label: 'Products',
                  color: Colors.green,
                ),
                _buildStatItem(
                  icon: Icons.edit,
                  value: '${user?.contributions.where((c) => c.type == 'price_update').length ?? 0}',
                  label: 'Updates',
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // How it works
            const Text(
              'How it works?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppTheme.primaryColor,
                        child: Text('1', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text('Add shop/product/price you found'),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppTheme.primaryColor,
                        child: Text('2', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text('Earn points for each contribution'),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: AppTheme.primaryColor,
                        child: Text('3', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text('Unlock badges and rewards'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Contribution Options
            const Text(
              'What would you like to contribute?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
              ),
              itemCount: _contributeOptions.length,
              itemBuilder: (context, index) {
                final option = _contributeOptions[index];
                return GestureDetector(
                  onTap: () {
                    if (index == 0) _showContributionDialog('shop');
                    else if (index == 1) _showContributionDialog('product');
                    else if (index == 2) _showContributionDialog('price_update');
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Coming soon!'),
                        ),
                      );
                    }
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: option['color'].withOpacity(0.1),
                            child: Icon(
                              option['icon'] as IconData,
                              color: option['color'],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            option['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            option['subtitle'],
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}